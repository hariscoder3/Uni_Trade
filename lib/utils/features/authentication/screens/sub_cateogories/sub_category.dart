import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/shimmer_loader/vertical_product_shimmer.dart';
import '../../../../constants/sizes.dart';
import '../../controllers/product/product_controller.dart';
import '../../../../../common/widgets/layout/grid_layout.dart';

class SubCategoriesScreen extends StatefulWidget {
  final String category;

  SubCategoriesScreen({Key? key, required this.category}) : super(key: key);

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  final ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProductsByCategory(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Banner

              // Sub-Categories
              Column(
                children: [
                  // Heading
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const TVerticalProductShimmer();
                    }
                    if (controller.filteredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No Data Found!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    return TGridLayout(
                      itemCount: controller.filteredProducts.length,
                      itemBuilder: (_, index) => TProductCardVertical(
                        product: controller.filteredProducts[index],
                      ),
                    ); // TGrid Layout
                  }), // Obx
                ], // Children
              ), // Column
            ], // Children
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
