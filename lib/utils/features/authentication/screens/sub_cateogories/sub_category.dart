import 'package:flutter/material.dart';

import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../common/widgets/products/product_cards/product_card_horizontal.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Phones')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              const TRoundedImage(
                  width: double.infinity,
                  imageUrl: "assets/images/products/product_mobile2.jpg",
                  applyImageRadius: true),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Sub-Categories
              Column(
                children: [
                  ///Heading
                  TSectionHeading(title: 'Infinix Mobiles', onPressed: () {}),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: TSizes.spaceBtwItems),
                      itemBuilder: (context, index) =>
                          const TProductCardHorizontal(),
                    ), //ListView.separated
                  ), //SizedBox
                ], //Children
              ), //Column
            ], //Children
          ), //Column
        ), //Padding
      ), //SingleChildScrollView
    ); //Scaffold
  }
}
