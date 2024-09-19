import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uni_trade/utils/features/authentication/chat/chat_page.dart';
//import 'chat_page.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  Future<List<Map<String, dynamic>>> _fetchChatRooms() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return [];
    }

    String currentUserId = currentUser.uid;
    List<Map<String, dynamic>> chatRooms = [];

    QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection('Users').get();

    Future<void> checkChatRoom(String userId1, String userId2) async {
      String chatRoomId = '${userId1}_$userId2';

      QuerySnapshot chatRoomsSnapshot = await FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection("messages")
          .get();

      if (chatRoomsSnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('chatRooms')
            .doc(chatRoomId)
            .get();
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        String currentUserValue = data[currentUserId];

        if (currentUserValue != 'disable') {
          if (currentUserId == userId1) {
            chatRooms.add({'id': userId2, 'chatRoomId': chatRoomId});
          } else {
            chatRooms.add({'id': userId1, 'chatRoomId': chatRoomId});
          }
        }
      }
    }

    List<Future<void>> futures = [];
    for (var userDoc in usersSnapshot.docs) {
      String otherUserId = userDoc.id;
      futures.add(checkChatRoom(currentUserId, otherUserId));
      futures.add(checkChatRoom(otherUserId, currentUserId));
    }

    await Future.wait(futures);

    return chatRooms;
  }

  Future<String> _getReceiverEmail(String receiverId) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId)
        .get();
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    return userData['Email'];
  }

  Future<void> _deleteChatRoom(BuildContext context, String chatRoomId) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String currentUserId = currentUser!.uid;
      var snapshot = await FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(chatRoomId)
          .update({currentUserId: 'disable'});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chat deleted successfully')),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting chat room: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchChatRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading chat rooms'));
          }

          List<Map<String, dynamic>> chatRooms = snapshot.data ?? [];

          if (chatRooms.isEmpty) {
            return const Center(child: Text('No chats available'));
          }

          return ListView.builder(
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              String receiverId = chatRooms[index]['id'];
              String chatRoomId = chatRooms[index]['chatRoomId'];

              return FutureBuilder<String>(
                future: _getReceiverEmail(receiverId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      title: Text('Loading...'),
                    );
                  }

                  if (snapshot.hasError) {
                    return const ListTile(
                      title: Text('Error loading email'),
                    );
                  }

                  String receiverEmail = snapshot.data ?? 'Unknown';

                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(receiverEmail),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        bool? confirmDelete = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Delete Chat'),
                            content: Text(
                                'Are you sure you want to delete this chat?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        );

                        if (confirmDelete == true) {
                          await _deleteChatRoom(context, chatRoomId);
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            receiverEmail: receiverEmail,
                            receiverID: receiverId,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
