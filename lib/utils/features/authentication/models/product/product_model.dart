import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String? userId;
  final String category;
  final String title;
  final String brandName;
  final String condition;
  final double price;
  final String description;
  Map<String, dynamic> image; // Updated to hold a single image URL

  ProductModel({
    required this.productId,
    required this.userId,
    required this.category,
    required this.title,
    required this.brandName,
    required this.condition,
    required this.price,
    required this.description,
    required this.image,
  });

  // Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'UserId': userId,
      'Category': category,
      'Title': title,
      'BrandName': brandName,
      'Condition': condition,
      'Price': price,
      'Description': description,
      'Image': image,
    };
  }

  // Factory method to create a ProductModel from a Firebase document snapshot.
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      productId: data['ProductId'] ?? '',
      userId: data['UserId'] ?? '',
      category: data['Category'] ?? '',
      title: data['Title'] ?? '',
      brandName: data['BrandName'] ?? '',
      condition: data['Condition'] ?? '',
      price: data['Price'] ?? 0.0,
      description: data['Description'] ?? '',
      image: data['Image'] ?? '',
    );
  }
}
