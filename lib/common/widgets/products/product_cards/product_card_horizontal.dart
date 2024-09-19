import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uni_trade/common/widgets/texts/product_title_text.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../icons/t_circular_icon.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/product_price_text.dart';
//producttitletext, productpricetext

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: TColors.softGrey,
      ), // BoxDecoration
      child: const Row(
        children: [
          ///ThumbNail
          TRoundedContainer(
            height: 120,
            padding: EdgeInsets.all(TSizes.sm),
            child: Stack(
              children: [
                /// -- Thumbnail Image
                SizedBox(
                  height: 110,
                  width: 110,
                  child: TRoundedImage(
                      imageUrl: "assets/images/products/product_mobile1.jpg",
                      applyImageRadius: true),
                ), // SizedBox

                /// -- Favourite Icon Button
                Positioned(
                  top: 0,
                  right: 0,
                  child: TCircularIcon(icon: Iconsax.heart5, color: Colors.red),
                ), //Positioned
              ], //Children
            ), //Stack
          ), //TRoundedContainer

          ///Details
          SizedBox(
            width: 142,
            child: Padding(
              padding: EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(
                          title: 'Infinix Hot 10 mobile', smallSize: true),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                    ], //Children
                  ), //Column

                  // Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Pricing
                      Flexible(child: TProductPriceText(price: '2500')),
                    ], //Children
                  ), //Row
                ], //Children
              ), //Column
            ), //Padding
          ), //SizedBox
        ],
      ), // Row
    ); // Container
  }
}
