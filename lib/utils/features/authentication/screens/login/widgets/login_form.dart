import 'package:flutter/material.dart';
import 'package:uni_trade/utils/constants/text_strings.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/constants/sizes.dart';
import 'package:uni_trade/utils/features/authentication/screens/password_configuration/forget_password.dart';

import '../../../../../constants/colors.dart';
import '../../../../../validators/validation.dart';
import '../../../controllers/login/login_controller.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: TTexts.email,
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
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Password
          Obx(
            () => TextFormField(
              validator: (value) => TValidator.validatePassword(value),
              controller: controller.password,
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
          const SizedBox(height: TSizes.spaceBtwInputFields / 2),

          /// Remember Me & Forget Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///Remember Me
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value),
                  ), //Obx
                  const Text(TTexts.rememberMe),
                ],
              ), // Row

              ///Forget password
              TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(TTexts.forgetPassword)),
            ],
          ), // Row
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Sign In Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.emailAndPasswordSignIn(),
              //onPressed: () => Get.to(() => const NavigationMenu()),
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors
                    .blue, // Set the custom shade of blue as background color
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .zero, // Set the corner radius to zero for a rectangular shape
                ),
              ),
              child: const Text(
                TTexts.signIn,
                style: TextStyle(
                  color: TColors
                      .black, // Set the text color to white or any color that contrasts well with the background
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// Create Account Button
        ],
      ), //Column
    );
  }
}
