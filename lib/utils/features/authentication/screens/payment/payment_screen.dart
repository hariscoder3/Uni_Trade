import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uni_trade/utils/features/authentication/screens/product_details/widgets/countdown.dart';

class PaymentScreen extends StatefulWidget {
  final String productId;

  const PaymentScreen({super.key, required this.productId});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late DateTime endTime;

  @override
  void initState() {
    super.initState();
    endTime = DateTime.now().add(Duration(hours: 72));
  }

  @override
  Widget build(BuildContext context) {
    final countdownDuration = endTime.difference(DateTime.now()).inSeconds;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    'Your product will arrive in 24-72 hours.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  BidCountdownTimer(bidEndTime: endTime),
                  const SizedBox(height: 20),
                  Text(
                    'Please confirm receipt of the product after a minimum of 24 hours.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (DateTime.now()
                    .isAfter(endTime.subtract(Duration(hours: 48)))) {
                  // Handle product received confirmation
                  print('Product received confirmed');
                } else {
                  Get.snackbar(
                    'Confirmation Error',
                    'You can only confirm the product received after 24 hours.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: Text('Product Received'),
            ),
          ],
        ),
      ),
    );
  }
}
