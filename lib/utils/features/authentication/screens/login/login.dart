import 'package:flutter/material.dart';
import 'package:uni_trade/common/styles/spacing_styles.dart';
import 'package:uni_trade/utils/constants/text_strings.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/constants/sizes.dart';
import 'package:uni_trade/utils/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:uni_trade/utils/features/authentication/screens/signup/signup.dart';

import '../../../../../navigation_menu.dart';
import '../../../../constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle
              .paddingWithAppBarHeight, // set padding for the screen
          child: Column(children: [
            /// Logo, Title & Sub-Title
            Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // align the children to the start of the column
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                      top: 50.0), // Adjust the top padding as needed
                  child: Center(
                    child: Text(
                      'Welcome to Uni Trade!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.sm),
                Text(TTexts.LoginSubTitle,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ), // Column
            const SizedBox(height: TSizes.spaceBtwSections),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                style: OutlinedButton.styleFrom(
                  backgroundColor: TColors
                      .blue, // Set the custom shade of blue as background color
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius
                        .zero, // Set the corner radius to zero for a rectangular shape
                  ),
                ),
                child: const Text(
                  TTexts.createAccount,
                  style: TextStyle(
                    color: Colors
                        .black, // Set the text color to white or any color that contrasts well with the background
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections / 2),

            // const SizedBox(height: TSizes.spaceBtwSections),
            //Divider between create account and sign in
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                    child: Divider(
                        color: TColors.darkGrey,
                        thickness: 0.5,
                        indent: 60,
                        endIndent: 5)),
                Text(TTexts.orSignInWith,
                    style: Theme.of(context).textTheme.labelMedium),
                const Flexible(
                    child: Divider(
                        color: TColors.darkGrey,
                        thickness: 0.5,
                        indent: 5,
                        endIndent: 60)),
              ],
            ), //Row
            const SizedBox(height: TSizes.spaceBtwSections / 2),

            /// Form
            Form(
              child: Column(
                children: [
                  /// Email
                  TextFormField(
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
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      labelText: TTexts.password,
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
                  const SizedBox(height: TSizes.spaceBtwInputFields / 2),

                  /// Remember Me & Forget Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Remember Me
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
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
                      onPressed: () => Get.to(() => const NavigationMenu()),
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
            ), //Padding
          ]), //Column
        ), //Padding
      ), //SingleChildScrollView
    ); //Scaffold
  }
}
