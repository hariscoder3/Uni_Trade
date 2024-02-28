import 'package:flutter/material.dart';

import '../../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../constants/sizes.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Price

            TProductPriceText(price: '1750', isLarge: true),
          ],
        ), // Row
        SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Title
        TProductTitleText(title: 'Infinix Hot 10 mobile'),
        SizedBox(height: TSizes.spaceBtwItems / 1.5),
      ],
    ); //Column
  }
}
