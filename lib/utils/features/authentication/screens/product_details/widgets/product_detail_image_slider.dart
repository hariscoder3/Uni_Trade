import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../constants/colors.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgesWidget(
      child: Container(
        color: TColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            const SizedBox(
                // height: 400,
                // child: Padding(
                //   padding: EdgeInsets.all(TSizes.productImageSize * 2),
                //   child: Center(
                child: Image(
                    image: AssetImage(
                        "assets/images/products/product_mobile2.jpg"))
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
