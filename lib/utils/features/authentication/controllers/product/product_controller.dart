import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:image_picker/image_picker.dart';
import 'package:uni_trade/common/widgets/loaders/loaders.dart';
import 'package:uni_trade/common/widgets/network/network_manager.dart';

import '../../../../../data/repositories/product/product_repository.dart';
import '../../../../../navigation_menu.dart';
import '../../models/product/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final productRepository = Get.put(ProductRepository());
  final imageUploading = false.obs;

  final categoryController = TextEditingController(text: 'Mobiles');
  final brandNameController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final titleController = TextEditingController();
  final conditionController = TextEditingController(text: 'New');
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  XFile? productImage;
  late Map<String, dynamic> json;

  final isLoading = false.obs;
  // for save fetched data
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxList<ProductModel> featuredProductsUser = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      // Show Loader while loading Products
      isLoading.value = true;

      // Fetch Products
      final products = await productRepository.getFeaturedProducts();
      final productsUser = await productRepository.getSpecificUserProducts();

      // Assign Products
      featuredProducts.assignAll(products);
      featuredProductsUser.assignAll(productsUser);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // upload product image
  uploadUserProfilePicture() async {
    try {
      productImage = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (productImage != null) {
        imageUploading.value = true;
        final imageUrl = await productRepository.uploadImage(
            'Products/Images/', productImage!);
        imageUploading.value = false;
        json = {'ProfilePicture': imageUrl};
        // return json;
      } else {
        TLoaders.warningSnackBar(
            title: 'Choose Image', message: "Image is necessary");
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Somethingf wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }

  // Add Product
  Future<void> addProduct() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: 'No Internet',
          message: 'Please check your internet connection.',
        );
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
        return;
      }

      // Prepare product data
      final productData = ProductModel(
        productId: '',
        userId: _auth.currentUser?.uid,
        category: categoryController.text,
        title: titleController.text,
        brandName: brandNameController.text,
        condition: conditionController.text,
        price: double.parse(priceController.text),
        description: descriptionController.text,
        image: json, // Placeholder for image URLs
      );

      // Add the product
      await productRepository.addProduct(productData);
      Get.offAll(() => const NavigationMenu());

      TLoaders.successSnackBar(
        title: 'Product Added',
        message: 'Your product has been successfully added.',
      );
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap',
        message: 'Something went wrong: $e',
      );
    }
  }
}
