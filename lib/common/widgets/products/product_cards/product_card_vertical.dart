import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/features/authentication/models/product/product_model.dart';
import 'package:uni_trade/utils/features/authentication/screens/product_details/product_detail.dart';
import '../../../styles/shadows.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../icons/t_circular_icon.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    ///Container with side paddings, colors, edges, radius and shadow
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetail(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: TColors.white,
        ), // BoxDecoration
        child: Column(
          children: [
            TRoundedContainer(
              width: 180,
              height: 160,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: TColors.light,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  Center(
                    child: TRoundedImage(
                      imageUrl: product.image['ProfilePicture'].toString(),
                      // imageUrl: "assets/images/products/product_mobile1.jpg",
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  /// -- Favourite Icon Button
                  const Positioned(
                    top: 0,
                    right: 0,
                    child:
                        TCircularIcon(icon: Iconsax.heart5, color: Colors.red),
                  ), //Positioned
                ],
              ), // Stack
            ), // TRoundedContainer
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            /// -- Details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(title: product.title, smallSize: true),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  Row(
                    children: [
                      Text(product.brandName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(width: TSizes.xs),
                      const Icon(Iconsax.verify5,
                          color: TColors.primary, size: TSizes.iconxs),
                    ], //Children
                  ), //Row
                ], //Children
              ), //Column
            ), //Padding
            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(price: product.price.toString()),
                ), //Padding
              ],
            ), //Row
          ], //Children
        ), // Column
      ), // Container
    ); //GestureDetector
  }
}
