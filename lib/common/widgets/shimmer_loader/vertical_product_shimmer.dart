import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../layout/grid_layout.dart';
import 'shimmer.dart';

class TVerticalProductShimmer extends StatelessWidget {
  const TVerticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, index) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            TShimmerEffect(
                width: 180,
                height:
                    180), //yeh effect hai hum normally bhi display karwa sakte waise
            SizedBox(height: TSizes.spaceBtwItems),

            /// Text
            TShimmerEffect(width: 160, height: 15),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            TShimmerEffect(width: 110, height: 15),
          ],
        ), // Column
      ), // SizedBox
    );
  }
}
