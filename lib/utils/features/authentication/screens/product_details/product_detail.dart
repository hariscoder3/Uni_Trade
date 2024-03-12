import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/features/authentication/models/product/product_model.dart';
import 'package:uni_trade/utils/features/authentication/screens/product_reviews/product_reviews.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../constants/sizes.dart';
import 'widgets/product_detail_image_slider.dart';
import 'widgets/product_meta_data.dart';
import 'widgets/rating_share_widget.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1 - Product Image Slider
            TProductImageSlider(product: product),

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
                  TProductMetaData(product: product),

                  /// - Description
                  const TSectionHeading(
                      title: 'Description', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    product.description,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
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
