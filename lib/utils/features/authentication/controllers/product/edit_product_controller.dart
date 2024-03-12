import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/features/authentication/controllers/product/product_controller.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../common/widgets/network/network_manager.dart';
import '../../../../../data/repositories/product/product_repository.dart';
import '../../../../../navigation_menu.dart';
import '../../../../popups/full_screen_loader.dart';

/// Controller to manage user-related functionality.
class EditProuctController extends GetxController {
  static EditProuctController get instance => Get.find();
  final productRepository = Get.put(ProductRepository());
  final productController = Get.put(ProductController());
  final imageUploading = false.obs;

  final categoryController = TextEditingController(text: 'Mobiles');
  final brandNameController = TextEditingController();
  final titleController = TextEditingController();
  final conditionController = TextEditingController(text: 'New');
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    // Future.delayed(const Duration(milliseconds: 100), () {
    //   initializeAll();
    // });
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeAll() async {
    categoryController.text = productController.categoryController.text;
    brandNameController.text = productController.brandNameController.text;
    titleController.text = productController.titleController.text;
    conditionController.text = productController.conditionController.text;
    priceController.text = productController.priceController.text;
    descriptionController.text = productController.descriptionController.text;
  }

  Future<void> updateProduct(String productId) async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are updating the product information...',
          "assets/animations/loading_animation.json");

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Validate input fields
      if (categoryController.text.isEmpty ||
          brandNameController.text.isEmpty ||
          titleController.text.isEmpty ||
          conditionController.text.isEmpty ||
          priceController.text.isEmpty ||
          descriptionController.text.isEmpty) {
        TLoaders.warningSnackBar(
          title: 'Incomplete Fields',
          message: 'Please fill in all the required fields.',
        );
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> product = {
        'Category': categoryController.text,
        'Title': titleController.text,
        'BrandName': brandNameController.text,
        'Condition': conditionController.text,
        'Price': double.parse(priceController.text),
        'Description': descriptionController.text
      };
      await productRepository.updateProductDetail(productId, product);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your product detail has been updated.');

      //Move to previous screen
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
