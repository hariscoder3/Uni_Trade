import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../../validators/validation.dart';
import '../../controllers/user/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      /// Custom Appbar
      appBar: AppBar(
        title: Text('Change Name',
            style: Theme.of(context).textTheme.headlineSmall),
      ), // TAppBar
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              'Choosing real name will be easy for several verifications',
              style: Theme.of(context).textTheme.labelMedium,
            ), // Text
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Text field and Button
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidator.validateEmptyText('First Name', value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: TTexts.firstName,
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
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Last Name', value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: TTexts.lastName,
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
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                style: ElevatedButton.styleFrom(
                  foregroundColor: TColors.blue,
                  backgroundColor: TColors.blue, // Text color
                  side: const BorderSide(color: TColors.blue), // Border color
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Square corners
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(color: TColors.black), // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
