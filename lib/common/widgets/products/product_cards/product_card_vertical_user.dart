import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:uni_trade/data/repositories/product/product_repository.dart';
import 'package:uni_trade/utils/features/authentication/models/product/product_model.dart';
import 'package:uni_trade/utils/features/authentication/screens/edit_product/edit_product.dart';
import 'package:uni_trade/utils/features/authentication/screens/product_details/product_detail.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../styles/shadows.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';

class TProductCardVerticalUser extends StatelessWidget {
  TProductCardVerticalUser({super.key, required this.product});

  final ProductModel product;
  final productRepository = Get.put(ProductRepository());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetail(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: TColors.white,
        ),
        child: Column(
          children: [
            TRoundedContainer(
              width: 180,
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: TColors.light,
              child: Stack(
                children: [
                  Center(
                    child: TRoundedImage(
                      imageUrl: product.image['ProfilePicture'].toString(),
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(title: product.title, smallSize: true),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      Row(
                        children: [
                          Text(
                            product.brandName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(width: TSizes.xs),
                          const Icon(Iconsax.verify5,
                              color: TColors.primary, size: TSizes.iconxs),
                        ],
                      ),
                    ],
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'edit') {
                        Get.to(() => EditProductScreen(product: product));
                      } else if (value == 'delete') {
                        Get.defaultDialog(
                          title: "Confirm Deletion",
                          content: const Text(
                              "Are you sure you want to delete this product?"),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                Get.back(); // Close the dialog
                                // Show loading animation while deleting
                                TFullScreenLoader.openLoadingDialog(
                                  'Deleting...',
                                  "assets/animations/loading_animation.json",
                                );

                                // Call the removeProduct method here
                                await productRepository
                                    .removeProduct(product.productId);

                                // Close loading animation after deletion
                                TFullScreenLoader.stopLoading();
                                Get.offAll(() => const NavigationMenu());
                                // onInit();
                              },
                              child: const Text("Yes"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back(); // Close the dialog
                              },
                              child: const Text("No"),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(price: product.price.toString()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
