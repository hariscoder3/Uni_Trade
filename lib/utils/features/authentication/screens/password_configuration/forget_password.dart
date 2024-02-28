import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/features/authentication/screens/password_configuration/reset_password.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(TTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(TTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: TSizes.spaceBtwSections * 2),

            /// Text field
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: TTexts.email,
                prefixIcon: Icon(Iconsax.direct_right),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: TColors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: TColors.blue),
                ),
                filled: true,
                fillColor: TColors.blue,
                labelStyle: TextStyle(color: TColors.black),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              ),
            ),
            // TextFormField
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.off(() => const ResetPassword()),
                style: ElevatedButton.styleFrom(
                  foregroundColor: TColors.black,
                  backgroundColor: TColors.blue,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Square corners
                  ),
                ),
                child: const Text(
                  TTexts.submit,
                  style: TextStyle(color: TColors.black), // Text color
                ),
              ), //SizedBox
            )
          ],
        ), //Column
      ), //Padding
    ); //Scaffold
  }
}
