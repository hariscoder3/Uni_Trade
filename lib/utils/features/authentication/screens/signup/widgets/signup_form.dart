import 'package:flutter/material.dart';
import 'package:uni_trade/utils/constants/colors.dart';
import 'package:uni_trade/utils/constants/sizes.dart';
import 'package:uni_trade/utils/constants/text_strings.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:uni_trade/utils/features/authentication/screens/signup/verify_email.dart';
import 'package:uni_trade/utils/features/authentication/screens/signup/widgets/terms_conditions.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: TColors
                              .blue), // Set the border color for focused state
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: TColors
                              .blue), // Set the border color for non-focused state
                    ),
                    filled: true,
                    fillColor: TColors.blue, // Set the background color
                    labelStyle:
                        TextStyle(color: TColors.black), // Set the text color
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0), // Adjust the horizontal padding
                  ),
                ),
              ), // Expanded
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: TColors
                              .blue), // Set the border color for focused state
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: TColors
                              .blue), // Set the border color for non-focused state
                    ),
                    filled: true,
                    fillColor: TColors.blue, // Set the background color
                    labelStyle:
                        TextStyle(color: TColors.black), // Set the text color
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0), // Adjust the horizontal padding
                  ),
                ),
                // TextFormField
              ), // Expanded
            ],
          ), // Row
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///Username

          ///Email
          TextFormField(
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: TColors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: TColors.blue),
              ),
              filled: true,
              fillColor: TColors.blue,
              labelStyle: TextStyle(color: TColors.black),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.0), // Adjust the horizontal padding
            ),
          ),
          // TextFormField
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///Phone Number
          TextFormField(
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: TColors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: TColors.blue),
              ),
              filled: true,
              fillColor: TColors.blue,
              labelStyle: TextStyle(color: Colors.black),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.0), // Adjust the horizontal padding
            ),
          ),
          // TextFormField
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///Password
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: TTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: TColors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: TColors.blue),
              ),
              filled: true,
              fillColor: TColors.blue,
              labelStyle: TextStyle(color: TColors.black),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.0), // Adjust the horizontal padding
            ),
          ),
          // TextFormField
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///Terms & Conditions Checkbox
          TermsConditions(), // Row
          const SizedBox(height: TSizes.spaceBtwSections),

          ///Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const VerifyEmailScreen()),
              style: ElevatedButton.styleFrom(
                foregroundColor: TColors.blue,
                backgroundColor: TColors.blue, // Text color
                side: const BorderSide(color: TColors.blue), // Border color
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Square corners
                ),
              ),
              child: const Text(
                "Register",
                style: TextStyle(color: TColors.black), // Text color
              ),
            ),
          ),
        ],
      ), //Column
    );
  }
}
