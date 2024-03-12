import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uni_trade/utils/features/authentication/controllers/product/product_controller.dart';

import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../common/widgets/layout/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/shimmer_loader/vertical_product_shimmer.dart';
import '../../../../constants/sizes.dart';
import '../home/home.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(
              icon: Iconsax.add,
              onPressed: () => Get.to(() => const HomeScreen())),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
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
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    );
  }
}
