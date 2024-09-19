import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_trade/utils/constants/sizes.dart';
import 'package:uni_trade/utils/features/authentication/models/product/product_model.dart';
import '../../../../constants/colors.dart';
import '../../controllers/product/edit_product_controller.dart';

class EditProductScreen extends StatelessWidget {
  final ProductModel product;

  EditProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editProductController = Get.put(EditProductController());

    // Set initial values for controllers based on the existing product
    editProductController.setInitialValues(product);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        backgroundColor: TColors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSizes.spaceBtwSections),

              // Image Upload Section
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      await editProductController.uploadProductImage();
                    },
                    icon: const Icon(Iconsax.image),
                    label: const Text('Upload Image'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: TColors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(() {
                    if (editProductController.imageUploaded.value) {
                      return const Icon(Icons.check, color: Colors.green);
                    } else {
                      return Container();
                    }
                  }),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: editProductController.categoryController.text,
                decoration: const InputDecoration(
                  labelText: 'Select Category',
                  fillColor: TColors.blue,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                onChanged: (value) {
                  editProductController.categoryController.text = value!;
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
                controller: editProductController.titleController,
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
                controller: editProductController.brandNameController,
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
                value: editProductController.conditionController.text,
                decoration: const InputDecoration(
                  labelText: 'Select Condition',
                  fillColor: TColors.blue,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                onChanged: (value) {
                  editProductController.conditionController.text = value!;
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
                controller: editProductController.priceController,
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
                controller: editProductController.descriptionController,
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

              // Save Changes Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await editProductController
                        .updateProduct(product.productId);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: TColors.blue,
                  ),
                  child: const Text('Save Changes'),
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
