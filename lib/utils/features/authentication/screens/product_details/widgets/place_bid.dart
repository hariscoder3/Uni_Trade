import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlaceBidScreen extends StatefulWidget {
  final String productId;
  final double productPrice;

  PlaceBidScreen({required this.productId, required this.productPrice});

  @override
  _PlaceBidScreenState createState() => _PlaceBidScreenState();
}

class _PlaceBidScreenState extends State<PlaceBidScreen> {
  final TextEditingController _bidPriceController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _bidPriceController.text = '0';
  }

  Future<void> _confirmBid() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not logged in');
        return;
      }

      double bidPrice = double.parse(_bidPriceController.text);
      if (bidPrice <= widget.productPrice) {
        Get.snackbar('Error', 'Bid price must be greater than product price');
        return;
      }

      // Fetch the highest bid for the given product
      QuerySnapshot highestBidSnapshot = await _firestore
          .collection('bids')
          .where('productId', isEqualTo: widget.productId)
          .orderBy('bidPrice', descending: true)
          .limit(1)
          .get();

      if (highestBidSnapshot.docs.isNotEmpty) {
        double highestBidPrice = highestBidSnapshot.docs.first['bidPrice'];
        if (bidPrice <= highestBidPrice) {
          Get.snackbar(
              'Error', 'Bid price must be greater than the highest bid price');
          return;
        }
      }

      String userId = user.uid;
      String email = user.email ?? 'no-email@example.com';

      await _firestore.collection('bids').add({
        'userId': userId,
        'email': email,
        'productId': widget.productId,
        'bidPrice': bidPrice,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bid Placed Successfully'),
            content: Text(
                'Your bid of PKR ${_bidPriceController.text} has been successfully placed.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Get.back(); // Close the dialog
                  Get.back(); // Close the bid screen
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Close button
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () => Get.back(),
              ),
            ),
            // Main content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter your Bid Price now',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Enter Bid Price'),
                            content: TextField(
                              controller: _bidPriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'PKR',
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'PKR ${_bidPriceController.text}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _confirmBid,
                    child: Text('Confirm Bidding'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.cyan,
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
