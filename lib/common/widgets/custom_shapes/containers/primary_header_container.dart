import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgesWidget(
      child: Container(
        color: TColors.blue,
        height: 350,
        padding: const EdgeInsets.only(bottom: 0),

        /// -- If [size.isFinite': is not true.in Stack] error occurred -> Read README.md file at [D
        child: Stack(
          children: [
            /// -- Background Custom Shapes
            Positioned(
                top: -150,
                right: -250,
                // top: 150,
                // right: -250,
                child: TCircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            Positioned(
                // top: -40,
                // right: 200,
                child: TCircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ), // Stack
      ), // Container
    ); // TCurvedEdgesWidget
  }
}
