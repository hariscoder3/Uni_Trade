import 'package:flutter/material.dart';
import 'package:uni_trade/utils/features/authentication/screens/signup/widgets/signup_form.dart';
import '../../../../../utils/constants/sizes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Center(
                child: Text(
                  'Uni Trade!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwInputFields),

              Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwInputFields * 2),

              /// Form
              SignUpForm(), //Form
              SizedBox(height: TSizes.spaceBtwSections),

              ///Divider
              // TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
              // TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
              // const SizedBox(width: TSizes.spaceBtwSections),

              // ///Social Buttons
              // const TSocialButtons(),
            ],
          ), //Column
        ), //Padding
      ), //SingleChildScrollingView
    ); //Scaffold
  }
}
