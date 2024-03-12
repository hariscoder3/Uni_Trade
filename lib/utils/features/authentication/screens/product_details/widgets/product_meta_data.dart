import 'package:flutter/material.dart';
import 'package:uni_trade/utils/features/authentication/models/product/product_model.dart';

import '../../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../constants/sizes.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Price

            TProductPriceText(price: product.price.toString(), isLarge: true),
          ],
        ), // Row
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Title
        TProductTitleText(title: product.title.toString()),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
      ],
    ); //Column
  }
}
