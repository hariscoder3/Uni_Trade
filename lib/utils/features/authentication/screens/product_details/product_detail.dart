import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/features/authentication/screens/product_reviews/product_reviews.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../constants/sizes.dart';
import 'widgets/product_detail_image_slider.dart';
import 'widgets/product_meta_data.dart';
import 'widgets/rating_share_widget.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1 - Product Image Slider
            const TProductImageSlider(),

            /// 2 - Product Details
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  /// - Rating & Share
                  const TRatingAndShare(),

                  /// - Price, Title, Stock, & Brand
                  const TProductMetaData(),

                  /// - Description
                  const TSectionHeading(
                      title: 'Description', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const ReadMoreText(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at imperdiet ligula. Sed id ligula nunc. Quisque egestas vulputate elit, vel efficitur arcu faucibus sed. Aliquam nec imperdiet ex, ac fermentum ex. Vivamus ex metus, ultricies et lacus vitae, tincidunt blandit tellus. Integer bibendum turpis quis elit lobortis vulputate. Integer elementum, arcu vel pharetra tempus, nibh nulla egestas nisi, nec vulputate dui justo sed mauris. Fusce ac diam ultrices, pulvinar urna ut, molestie enim. Etiam posuere semper neque vel finibus. Donec eget elit eu',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ), //ReadMoreText

                  /// - Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                          title: 'Reviews (4)', showActionButton: false),
                      IconButton(
                          icon: const Icon(Iconsax.arrow_right_3, size: 18),
                          onPressed: () =>
                              Get.to(const ProductReviewsScreen())),
                    ],
                  ), // Row
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ), // Column
            ), // Padding
          ], //children
        ), //Column
      ), //SingleChildAScrollView
    ); //Scaffold
  }
}
