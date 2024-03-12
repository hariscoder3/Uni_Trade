import 'package:flutter/material.dart';
import 'package:uni_trade/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/features/authentication/screens/sub_cateogories/sub_category.dart';

import '../../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return TVerticalImageText(
            image: "assets/icons/smartphone.png",
            title: 'Mobile Phones',
            onTap: () => Get.to(() => const SubCategoriesScreen()),
            textColor: TColors.black,
          );
        },
      ), // ListView.builder
    ); // SizedBox
  }
}
