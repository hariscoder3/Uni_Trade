import 'package:flutter/material.dart';
import 'package:uni_trade/data/repositories/authentication/authentication_repository.dart';
import 'package:uni_trade/utils/features/authentication/controllers/user/user_controller.dart';
import 'package:get/get.dart';

import 'package:uni_trade/utils/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:uni_trade/utils/features/authentication/screens/profile/change_name.dart';
import '../../../../../common/widgets/images/t_circular_image.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),

      /// -- Body
      body: FutureBuilder(
        future: controller.fetchUserRecord(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile data'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Profile Picture
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Obx(() {
                          final networkImage =
                              controller.user.value.profilePicture;
                          final image = networkImage.isNotEmpty
                              ? networkImage
                              : "assets/images/user/employee.png";
                          return TCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty);
                        }),
                        TextButton(
                            onPressed: () =>
                                controller.uploadUserProfilePicture(),
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
                      title: 'Name',
                      value: controller.user.value.fullName,
                      onPressed: () => Get.to(() => const ChangeName())),

                  ///Heading Personal Info
                  TProfileMenu(
                      title: 'E-mail',
                      value: controller.user.value.email,
                      onPressed: () {}),
                  TProfileMenu(
                      title: 'Phone Number',
                      value: controller.user.value.phoneNumber,
                      onPressed: () {}),
                  TProfileMenu(
                      title: 'Forget Password',
                      value: '*********',
                      onPressed: () => Get.to(() => const ForgetPassword())),

                  TextButton(
                      onPressed: () =>
                          AuthenticationRepository.instance.logout(),
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: TColors.blue),
                      )),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => controller.deleteAccountWarningPopup(),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.red, // Text color
                        side:
                            const BorderSide(color: Colors.red), // Border color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // Square corners
                        ),
                      ),
                      child: const Text('Permanently Delete Account',
                          style: TextStyle(color: TColors.black)),
                    ), //TextButton
                  ), //Center
                ],
              ), // Column
            ), // Padding
          ); // SingleChildScrollView
        },
      ),
    ); // Scaffold
  }
}
