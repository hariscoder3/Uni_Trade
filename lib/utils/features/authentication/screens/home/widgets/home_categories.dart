import 'package:flutter/material.dart';
import 'package:uni_trade/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/features/authentication/screens/sub_cateogories/sub_category.dart';

import '../../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  final List<Map<String, String>> categories = const [
    {"title": "Mobiles", "image": "assets/icons/smartphone.png"},
    {"title": "Watches", "image": "assets/icons/watch.png"},
    {"title": "Books", "image": "assets/icons/book.png"},
    {"title": "Accessories", "image": "assets/icons/accessorie.png"},
    {"title": "Bags", "image": "assets/icons/bag.png"},
    {"title": "Calculators", "image": "assets/icons/calculator.png"},
    {"title": "E-Gadgets", "image": "assets/icons/gadget.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final category = categories[index];
          return TVerticalImageText(
            image: category["image"]!,
            title: category["title"]!,
            onTap: () => Get.to(() =>
                SubCategoriesScreen(category: category['title'] as String)),
            textColor: TColors.black,
          );
        },
      ), // ListView.builder
    ); // SizedBox
  }
}
