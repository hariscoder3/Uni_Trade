import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/features/authentication/screens/login/login.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../utils/constants/colors.dart';
import '../styles/spacing_styles.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              /// Image
              Image(
                  image: const AssetImage("assets/images/account-verified.png"),
                  width: THelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Title & SubTitle
              Text(title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center), // Text
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(subTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center), // Text
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const LoginScreen()),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: TColors.black,
                    backgroundColor: TColors.blue, // Text color
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Square corners
                    ),
                  ),
                  child: const Text(
                    TTexts.tContinue,
                    style: TextStyle(color: TColors.black), // Text color
                  ),
                ), // SizedBox
              )
            ], // children
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
