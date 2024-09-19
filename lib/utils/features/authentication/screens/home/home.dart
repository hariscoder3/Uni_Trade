import 'package:flutter/material.dart';
import 'package:uni_trade/utils/features/authentication/screens/all_products/all_products.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../../common/widgets/layout/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/shimmer_loader/vertical_product_shimmer.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../controllers/product/product_controller.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  ///Appbar
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections / 2),

                  ///SearchBar
                  TSearchContainer(text: 'What are you looking for'),
                  SizedBox(height: TSizes.spaceBtwSections / 2),

                  ///Categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// -- Heading
                        TSectionHeading(
                            title: 'Popular Categories',
                            showActionButton: false,
                            textColor: TColors.black),
                        SizedBox(height: TSizes.spaceBtwItems / 2),

                        ///Categories
                        THomeCategories(),
                      ],
                    ), //Column
                  ) //Padding
                ],
              ), //Column
            ), //TPrimaryHeaderContainer

            ///Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  ///Promo Slider
                  const TPromoSlider(banners: [
                    "assets/images/slider_image1.png",
                    "assets/images/slider_image2.jpg",
                    "assets/images/slider_image3.jpg"
                  ]),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  ///Heading
                  TSectionHeading(
                      title: 'Recent Products',
                      onPressed: () => Get.to(() => AllProducts())),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  ///Popular Products
                  ///Popular Products
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const TVerticalProductShimmer();
                    }
                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                          child: Text('No Data Found!',
                              style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return TGridLayout(
                      itemCount: controller.featuredProducts.length > 2
                          ? 2
                          : controller.featuredProducts.length,
                      itemBuilder: (_, index) => TProductCardVertical(
                          product: controller.featuredProducts[index]),
                    ); // TGrid Layout
                  }), //Obx
                ],
              ), //Column
            ), //Padding
          ], // Children
        ), // Column
      ), // SingleChildScrollView
    ); //Scaffold
  }
}
