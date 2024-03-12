import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layout/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical_user.dart';
import '../../../../../common/widgets/shimmer_loader/vertical_product_shimmer.dart';
import '../../controllers/product/product_controller.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Products
            Obx(() {
              if (controller.isLoading.value) {
                return const TVerticalProductShimmer();
              }
              if (controller.featuredProductsUser.isEmpty) {
                return Center(
                    child: Text('No Data Found!',
                        style: Theme.of(context).textTheme.bodyMedium));
              }
              return TGridLayout(
                itemCount: controller.featuredProductsUser.length,
                itemBuilder: (_, index) => TProductCardVerticalUser(
                    product: controller.featuredProductsUser[index]),
              );
              // TGrid Layout
            }), //Obx
          ], // Children
        ),
      ),
    );
  }
}
