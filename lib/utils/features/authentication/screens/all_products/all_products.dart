import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layout/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/shimmer_loader/vertical_product_shimmer.dart';
import '../../../../constants/sizes.dart';
import '../../controllers/product/product_controller.dart';

class AllProducts extends StatelessWidget {
  AllProducts({super.key});
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Products')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Products
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
                  itemCount: controller.featuredProducts.length,
                  itemBuilder: (_, index) => TProductCardVertical(
                      product: controller.featuredProducts[index]),
                ); // TGrid Layout
              }), //Obx
            ], // Children
          ), // Column
        ), // Padding
      ), //SingleChildScrollView
    ); // Scaffold
  }
}
