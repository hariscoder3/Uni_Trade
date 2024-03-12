import 'package:flutter/material.dart';
import 'package:uni_trade/utils/features/authentication/controllers/user/user_controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../../validators/validation.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: (value) => TValidator.validateEmail(value),
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
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0), // Adjust the horizontal padding
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                ///Password

                Obx(
                  () => TextFormField(
                    validator: (value) =>
                        TValidator.validateEmptyText('Password', value),
                    controller: controller.verifyPassword,
                    obscureText: controller.hidePassword.value,
                    decoration: InputDecoration(
                      labelText: TTexts.password,
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye),
                      ), // IconButton
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
                      ),
                    ), // InputDecoration
                  ), // TextFormField
                ), // Obx
                const SizedBox(height: TSizes.spaceBtwSections),

                /// LOGIN Button

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.reAuthenticateEmailAndPasswordUser(),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: TColors.blue,
                      backgroundColor: TColors.blue, // Text color
                      side:
                          const BorderSide(color: TColors.blue), // Border color
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Square corners
                      ),
                    ),
                    child: const Text(
                      "Verify",
                      style: TextStyle(color: TColors.black), // Text color
                    ),
                  ),
                ),
              ],
            ), //Column
          ), //Form
        ), //padding
      ), //SingleChildScrollView
    );
  }
}
