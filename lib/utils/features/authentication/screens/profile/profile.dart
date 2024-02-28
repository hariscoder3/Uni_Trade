import 'package:flutter/material.dart';
import 'package:uni_trade/utils/features/authentication/screens/login/login.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/images/t_circular_image.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const TCircularImage(
                        image: "assets/images/user/employee.png",
                        width: 80,
                        height: 80),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Change Profile Picture')),
                  ],
                ), // Column
              ), // SizedBox

              ///Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///Heading Profile Info
              const TSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                  title: 'Name', value: 'Harris Ellahi', onPressed: () {}),

              ///Heading Personal Info
              TProfileMenu(
                  title: 'E-mail', value: 'harris@gmail.com', onPressed: () {}),
              TProfileMenu(
                  title: 'Phone Number', value: '+920000000', onPressed: () {}),
              TProfileMenu(
                  title: 'Forget Password',
                  value: '*********',
                  onPressed: () {}),

              Center(
                child: ElevatedButton(
                  onPressed: () => Get.to(() => LoginScreen()),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: TColors.blue,
                    backgroundColor: TColors.blue, // Text color
                    side: const BorderSide(color: TColors.blue), // Border color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Square corners
                    ),
                  ),
                  child: const Text('Logout',
                      style: TextStyle(color: TColors.black)),
                ), //TextButton
              ), //Center
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
