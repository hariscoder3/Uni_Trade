import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uni_trade/common/widgets/texts/section_heading.dart';
import 'package:uni_trade/utils/constants/sizes.dart';

class BidCountdownTimer extends StatefulWidget {
  final DateTime bidEndTime;

  const BidCountdownTimer({Key? key, required this.bidEndTime})
      : super(key: key);

  @override
  _BidCountdownTimerState createState() => _BidCountdownTimerState();
}

class _BidCountdownTimerState extends State<BidCountdownTimer> {
  late Duration remainingTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.bidEndTime.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = widget.bidEndTime.difference(DateTime.now());
        if (remainingTime.isNegative) {
          _timer.cancel();
          remainingTime = Duration.zero;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TSectionHeading(title: 'Bid Countdown', showActionButton: false),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text(
          _formatDuration(remainingTime),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
