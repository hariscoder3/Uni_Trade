import 'package:flutter/material.dart';
import 'package:uni_trade/utils/constants/colors.dart';
import 'package:uni_trade/utils/constants/sizes.dart';
import 'package:uni_trade/utils/constants/text_strings.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:uni_trade/utils/features/authentication/controllers/signup/signup_controller.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/validators/validation.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return SingleChildScrollView(
      child: Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidator.validateEmptyText('First Name', value),
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
                    controller: controller.lastName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Last Name', value),
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
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
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
              controller: controller.phoneNumber,
              validator: (value) => TValidator.validatePhoneNumber(value),
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
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => TValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: GestureDetector(
                    onTap: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    child: const Icon(Iconsax.eye_slash),
                  ), // GestureDetector
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: TColors.blue),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: TColors.blue),
                  ),
                  filled: true,
                  fillColor: TColors.blue,
                  labelStyle: const TextStyle(color: TColors.black),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ), // Adjust the horizontal padding
                ),
              ), // TextFormField
            ), // Obx

            const SizedBox(height: TSizes.spaceBtwInputFields),

            ///Terms & Conditions Checkbox

            const SizedBox(height: TSizes.spaceBtwSections),

            ///Sign Up Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signup(),
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
      ),
    );
  }
}
