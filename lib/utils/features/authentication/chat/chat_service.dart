import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:uni_trade/utils/features/authentication/chat/get_server_key.dart';
import '../models/message/message.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Send message
  Future<void> sendMessage(String receiverID, String message) async {
    // Get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // Construct chat room ID
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // Sort the ids
    String chatRoomID = ids.join('_');

    // Add new message to database
    await _firestore
        .collection("chatRooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());

    await _firestore
        .collection("chatRooms")
        .doc(chatRoomID)
        .set({currentUserID: 'enable', receiverID: 'enable'});

    // Send push notification
    await sendPushNotification(receiverID, message, currentUserEmail);
  }

  // Get messages
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    // Construct a chatroom ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chatRooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  // Get chat rooms for the current user
  Stream<QuerySnapshot> getChatRooms() {
    final String currentUserID = _auth.currentUser!.uid;

    return _firestore
        .collection("chatRooms")
        .where("users", arrayContains: currentUserID)
        .snapshots();
  }

  // Get other user's email
  Future<String> getUserEmail(String userID) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userID).get();
    return userDoc['email'];
  }

  // Send push notification
  Future<void> sendPushNotification(
      String receiverID, String message, String currentUserEmail) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('Users').doc(receiverID).get();
    if (userDoc.exists) {
      String token = userDoc['fcmToken'];
      GetServerKey getServerKey = GetServerKey();
      String accessToken = await getServerKey.getServerKeyToken();

      final String serverKey = accessToken;
      print(token);
      String endpointFCM =
          "https://fcm.googleapis.com/v1/projects/unitrade-5b903/messages:send";
      final Map<String, dynamic> bodyMessage = {
        'message': {
          'token': token,
          'notification': {
            'title': currentUserEmail,
            'body': message,
          },
          'data': {}
        }
      };

      final http.Response response = await http.post(Uri.parse(endpointFCM),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $serverKey',
          },
          body: jsonEncode(bodyMessage));

      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Sent Notification successfully");
      } else {
        print("Failed Notification");
      }
    }
  }
}
