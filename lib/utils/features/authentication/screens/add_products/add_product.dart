import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:uni_trade/utils/constants/sizes.dart';
import '../../../../constants/colors.dart';
import '../../controllers/product/product_controller.dart';

class AddProductScreen extends StatelessWidget {
  final productController = Get.put(ProductController());
  final RxBool nonBid = false.obs;

  AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: TColors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSizes.spaceBtwSections),

              // Upload Images Section
              Obx(() {
                return ElevatedButton.icon(
                  onPressed: () async {
                    await productController.uploadUserProfilePicture();
                  },
                  icon: productController.imageUploading.value
                      ? Icon(Icons.check, color: Colors.green)
                      : productController.imageUploaded.value
                          ? Icon(Icons.check, color: Colors.green)
                          : Icon(Iconsax.image),
                  label: const Text('Upload Images'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: TColors.blue,
                  ),
                );
              }),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: productController.categoryController.text,
                decoration: const InputDecoration(
                  labelText: 'Select Category',
                  fillColor: TColors.blue,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                onChanged: (value) {
                  productController.categoryController.text = value!;
                },
                items: [
                  'Mobiles',
                  'Watches',
                  'Books',
                  'Accessories',
                  'Bags',
                  'Calculators',
                  'E-Gadgets'
                ].map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Title Input
              TextFormField(
                controller: productController.titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  fillColor: TColors.blue,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Brand Name Input
              TextFormField(
                controller: productController.brandNameController,
                decoration: const InputDecoration(
                  labelText: 'Brand Name',
                  fillColor: TColors.blue,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Condition Dropdown
              DropdownButtonFormField<String>(
                value: productController.conditionController.text,
                decoration: const InputDecoration(
                  labelText: 'Select Condition',
                  fillColor: TColors.blue,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                onChanged: (value) {
                  productController.conditionController.text = value!;
                },
                items: [
                  'New',
                  'Used',
                ].map((condition) {
                  return DropdownMenuItem<String>(
                    value: condition,
                    child: Text(condition),
                  );
                }).toList(),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Price Input
              TextFormField(
                controller: productController.priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  fillColor: TColors.blue,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Description Input
              TextFormField(
                controller: productController.descriptionController,
                maxLines: 2,
                maxLength: 100,
                decoration: const InputDecoration(
                  labelText: 'Description (Max 100 words)',
                  fillColor: TColors.blue,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Non-bid Checkbox
              Obx(() {
                return CheckboxListTile(
                  title: const Text('Non-bid'),
                  value: nonBid.value,
                  onChanged: (value) {
                    nonBid.value = value!;
                    if (value) {
                      productController.bidDurationController.text = 'non-bid';
                    } else {
                      productController.bidDurationController.text = '';
                    }
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: TColors.blue,
                );
              }),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Bid Duration Input (only shown if Non-bid is not checked)
              Obx(() {
                return nonBid.value
                    ? Container()
                    : TextFormField(
                        controller: productController.bidDurationController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Bid Duration (in hours, 24-48)',
                          fillColor: TColors.blue,
                          filled: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      );
              }),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Post Now Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await productController.addProduct();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: TColors.blue,
                  ),
                  child: const Text('Post Now'),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
