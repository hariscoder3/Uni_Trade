import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_trade/common/widgets/success_screen.dart';
// import '../../../../utils/constants/sizes.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../../helpers/helper_functions.dart';
import '../login/login.dart';

//textstrings, helper functions, image strings aur login.dart jaha save kiya hai tumne apne file
//folder structure k hisaab se on sab ko bhi import karlena

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear)),
        ],
      ), //AppBar
      body: SingleChildScrollView(
        //Padding to give default equal space on all sides in all screens
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              Image(
                image: const AssetImage("assets/images/verify-account.png"),
                width: THelperFunctions.screenWidth() * 0.5,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Title & SubTitle
              Text(TTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text('201370000@gift.edu.pk',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(TTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.to(
                            () => SuccessScreen(
                              image: "assets/images/account-verified.png",
                              title: TTexts.yourAccountCreatedTitle,
                              subTitle: TTexts.yourAccountCreatedSubTitle,
                              onPressed: () =>
                                  Get.to(() => const LoginScreen()),
                            ), // SuccessScreen
                          ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: TColors.black,
                        backgroundColor: TColors.blue, // Text color
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Square corners
                        ),
                      ),
                      child: const Text(
                        TTexts.tContinue,
                        style: TextStyle(color: Colors.black),
                      )) //ElevatedButton
                  ), //SizedBox
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: TColors.blue,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Square corners
                        ),
                      ),
                      child: const Text(TTexts.resendEmail,
                          style: TextStyle(color: TColors.black)))),
            ],
          ), //Column
        ), //Padding
      ), //SingleChildScrollView
    ); //Scaffold
  }
}
