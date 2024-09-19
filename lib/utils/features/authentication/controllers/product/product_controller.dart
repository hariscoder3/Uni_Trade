import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uni_trade/common/widgets/loaders/loaders.dart';
import 'package:uni_trade/common/widgets/network/network_manager.dart';

import '../../../../../data/repositories/product/product_repository.dart';
import '../../../../../navigation_menu.dart';
import '../../models/product/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final productRepository = Get.put(ProductRepository());
  final imageUploading = false.obs;
  final imageUploaded = false.obs; // New flag to check if image is uploaded
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final categoryController = TextEditingController(text: 'Mobiles');
  final brandNameController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final titleController = TextEditingController();
  final conditionController = TextEditingController(text: 'New');
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final bidDurationController =
      TextEditingController(text: '24'); // Default to 24 hours
  XFile? productImage;
  late Map<String, dynamic> json = {};
  var nonBid = false;

  final isLoading = false.obs;
  // for save fetched data
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxList<ProductModel> featuredProductsUser = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  Future<void> fetchProductsByCategory(String category) async {
    try {
      print("Fetching products for category: " + category);
      isLoading(true);

      final snapshot = await _db
          .collection('Product')
          .where('Category', isEqualTo: category)
          .get();

      if (snapshot.docs.isEmpty) {
        print("No products found for the category: " + category);
      } else {
        filteredProducts.assignAll(
            snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList());
        print("Products fetched successfully.");
      }
    } on FirebaseException catch (e) {
      print("FirebaseException occurred: ${e.message}");
    } catch (e) {
      print("An error occurred: ${e.toString()}");
    } finally {
      isLoading(false);
    }
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
  Future<void> uploadUserProfilePicture() async {
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
        imageUploaded.value = true; // Set flag to true when image is uploaded
      } else {
        TLoaders.warningSnackBar(
            title: 'Choose Image', message: "Image is necessary");
        imageUploaded.value =
            false; // Ensure flag is false if no image is selected
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh Snap', message: 'Something went wrong: $e');
      imageUploaded.value = false; // Ensure flag is false if an error occurs
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

      // Check if image is uploaded
      if (!imageUploaded.value) {
        TLoaders.warningSnackBar(
          title: 'No Image',
          message: 'Please upload an image before adding the product.',
        );
        return;
      }

      // Validate input fields
      if (categoryController.text.isEmpty ||
          brandNameController.text.isEmpty ||
          titleController.text.isEmpty ||
          conditionController.text.isEmpty ||
          priceController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          bidDurationController.text.isEmpty) {
        TLoaders.warningSnackBar(
          title: 'Incomplete Fields',
          message: 'Please fill in all the required fields.',
        );
        return;
      }

      // Validate bid duration
      if (bidDurationController.text.trim() != 'non-bid') {
        int bidDuration = int.parse(bidDurationController.text);
        if (bidDuration < 24 || bidDuration > 48) {
          TLoaders.warningSnackBar(
            title: 'Invalid Bid Duration',
            message: 'Bid duration should be between 24 and 48 hours.',
          );
          return;
        }
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
        bidEndTime: _parseBidEndTime(bidDurationController.text),
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

  DateTime? _parseBidEndTime(String text) {
    try {
      int hours = int.parse(text);
      return DateTime.now().add(Duration(hours: hours));
    } catch (e) {
      return null;
    }
  }
}
