import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_trade/utils/features/authentication/controllers/product/product_controller.dart';
import 'package:uni_trade/utils/features/authentication/models/product/product_model.dart';
import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../common/widgets/network/network_manager.dart';
import '../../../../../data/repositories/product/product_repository.dart';
import '../../../../../navigation_menu.dart';
import '../../../../popups/full_screen_loader.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();
  final productRepository = Get.put(ProductRepository());
  final productController = Get.put(ProductController());
  final imageUploading = false.obs;
  final imageUploaded = false.obs;
  Rx<XFile?> productImage = Rx<XFile?>(null);
  late Map<String, dynamic> json = {};

  final categoryController = TextEditingController(text: 'Mobiles');
  final brandNameController = TextEditingController();
  final titleController = TextEditingController();
  final conditionController = TextEditingController(text: 'New');
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? bidEndTime;

  @override
  void onInit() {
    super.onInit();
  }

  void setInitialValues(ProductModel product) {
    categoryController.text = product.category;
    brandNameController.text = product.brandName;
    titleController.text = product.title;
    conditionController.text = product.condition;
    priceController.text = product.price.toString();
    descriptionController.text = product.description;
    bidEndTime = product.bidEndTime;
    json = product.image;
  }

  Future<void> uploadProductImage() async {
    try {
      productImage.value = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (productImage.value != null) {
        imageUploading.value = true;
        final imageUrl = await productRepository.uploadImage(
            'Products/Images/', productImage.value!);
        imageUploaded.value = true;
        imageUploading.value = false;
        json = {'ProfilePicture': imageUrl};
      } else {
        TLoaders.warningSnackBar(
          title: 'Choose Image',
          message: 'Image is necessary',
        );
        imageUploaded.value = false;
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap',
        message: 'Something went wrong: $e',
      );
      imageUploaded.value = false;
    } finally {
      imageUploading.value = false;
    }
  }

  Future<void> updateProduct(String productId) async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'We are updating the product information...',
        "assets/animations/loading_animation.json",
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

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

      Map<String, dynamic> product = {
        'Category': categoryController.text,
        'Title': titleController.text,
        'BrandName': brandNameController.text,
        'Condition': conditionController.text,
        'Price': double.tryParse(priceController.text) ?? 0.0,
        'Description': descriptionController.text,
        'Image': json.isNotEmpty ? json : null,
        'bidEndTime': bidEndTime?.toIso8601String(),
      };

      await productRepository.updateProductDetail(productId, product);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your product detail has been updated.',
      );

      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Oh Snap',
        message: e.toString(),
      );
    }
  }
}
