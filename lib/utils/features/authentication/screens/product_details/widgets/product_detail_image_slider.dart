import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/features/authentication/controllers/product/images_controller.dart';

import '../../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../constants/colors.dart';
import '../../../models/product/product_model.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    return TCurvedEdgesWidget(
      child: Container(
        color: TColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              // height: 400,
              // child: Padding(
              //   padding: EdgeInsets.all(TSizes.productImageSize * 2),
              //   child: Center(
              child: Center(
                  child: GestureDetector(
                onTap: () => controller
                    .showEnlargedImage(product.image['ProfilePicture']),
                child: CachedNetworkImage(
                  imageUrl: product.image['ProfilePicture'],
                ), //CachedNetworkImage
              ) //GestureDetector

                  ), //Obx,Center
              // ),
              // ), // Padding
            ), // SizedBox,

            /// Image Slider

            ///AppBar icons
            AppBar(
              actions: const [
                TCircularIcon(icon: Iconsax.heart5, color: Colors.red)
              ],
            ), // TAppBar
          ],
        ), //Stack
      ), //Container
    ); //TCurvedEdgesWidget
  }
}
