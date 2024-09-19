import 'package:flutter/material.dart';
import 'package:uni_trade/utils/features/authentication/chat/chat_service.dart';
import 'package:uni_trade/utils/features/authentication/chat/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controller
  final TextEditingController _messageController = TextEditingController();

  // chat and auth services
  final ChatService _chatService = ChatService();
  final FirebaseAuth _authService = FirebaseAuth.instance;

  //for text field focus
  final myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so that the keyboard has time to show up
        // then the amount of remaining space will be calculated,
        // then scroll down
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        ); // Future.delayed
      }
    });

    //wait a bit
    // Future.delayed(
    //   const Duration(milliseconds: 500),
    //   () => scrollDown(),
    // );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  //send message
  void sendMessage() async {
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      // Call the ChatGPT API to check for offensive content
      bool isOffensive =
          await checkForOffensiveContent(_messageController.text);
      print(isOffensive);
      if (isOffensive) {
        // Show a top toast message of violence detected
        Fluttertoast.showToast(
            msg: "Violence or offensive content detected!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        String text_message = _messageController.text;
        _messageController.clear();
        // Send the message
        await _chatService.sendMessage(widget.receiverID, text_message);
      }

      scrollDown();
    }
  }

  Future<bool> checkForOffensiveContent(String message) async {
    final apiKey = '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';
    final url = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'system',
            'content':
                'You are an assistant that helps identify offensive content.'
          },
          {
            'role': 'user',
            'content':
                'Check if the following message contains hate speech, violence, offensive language, or impolite: "$message". Respond with "y" or "n".'
          },
        ],
        'max_tokens': 500,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String reply =
          responseData['choices'][0]['message']['content'].trim().toLowerCase();
      return reply == 'y' || reply == 'y.';
    } else {
      throw Exception('Failed to call OpenAI API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ), // AppBar
      body: Column(children: [
        // display all messages
        Expanded(
          child: _buildMessageList(),
        ), //Expanded

        // user input
        _buildUserInput(),
      ]), // Column
    ); // Scaffold
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        // return list view
        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data['senderID'] == _authService.currentUser!.uid;

    //align message to right
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
        ],
      ),
    );
  }

  //build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0, left: 20),
      child: Row(
        children: [
          // textfield should take up most of the space
          Expanded(
            child: TextField(
              controller: _messageController,
              // hintText: "Type a message",
              obscureText: false,
              focusNode: myFocusNode,
            ), // MyTextField
          ), // Expanded

          // send button
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ), // BoxDecoration
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ), // Icon
            ), // IconButton
          ), // Container
        ], // children
      ), // Row
    ); // Padding
  }
}
