import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uni_trade/utils/features/authentication/chat/chat_service.dart';
import 'package:uni_trade/utils/features/authentication/models/product/product_model.dart';
import 'package:uni_trade/utils/features/authentication/screens/payment/payment_screen.dart';
import 'package:uni_trade/utils/features/authentication/screens/product_details/widgets/countdown.dart';
import 'package:uni_trade/utils/features/authentication/screens/product_details/widgets/place_bid.dart';
import 'package:uni_trade/utils/features/authentication/screens/product_details/widgets/view_bids.dart';
import 'package:uni_trade/utils/features/authentication/screens/product_reviews/product_reviews.dart';
import 'package:uni_trade/utils/features/authentication/chat/chat_page.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../constants/sizes.dart';
import 'widgets/product_detail_image_slider.dart';
import 'widgets/product_meta_data.dart';
import 'widgets/rating_share_widget.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final bool isBid = product.bidEndTime != null;
    final bool isBidTimeOver =
        isBid && DateTime.now().isAfter(product.bidEndTime!);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                /// 1 - Product Image Slider
                TProductImageSlider(product: product),

                /// 2 - Product Details
                Padding(
                  padding: const EdgeInsets.only(
                      right: TSizes.defaultSpace,
                      left: TSizes.defaultSpace,
                      bottom: TSizes.defaultSpace),
                  child: Column(
                    children: [
                      /// - Rating & Share
                      const TRatingAndShare(),

                      /// - Price, Title, Stock, & Brand
                      TProductMetaData(product: product),

                      /// - Description
                      const TSectionHeading(
                          title: 'Description', showActionButton: false),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      ReadMoreText(
                        product.description,
                        trimLines: 2,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Less',
                        moreStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                        lessStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      ), //ReadMoreText

                      /// - Reviews
                      const Divider(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TSectionHeading(
                              title: 'Reviews (0)', showActionButton: false),
                          IconButton(
                              icon: const Icon(Iconsax.arrow_right_3, size: 18),
                              onPressed: () => print(isBidTimeOver)
                              // Get.to(const ProductReviewsScreen())
                              ),
                        ],
                      ), // Row
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// - Bid Countdown Timer
                      if (isBid)
                        BidCountdownTimer(bidEndTime: product.bidEndTime!),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ), // Column
                ), // Padding
              ], //children
            ), //Column
          ), //SingleChildScrollView

          /// - Bottom Boxes
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.cyan,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  if (product.userId != currentUser?.uid && !isBidTimeOver) ...[
                    /// - Chat Box
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () async {
                          DocumentSnapshot userdoc = await _firestore
                              .collection('Users')
                              .doc(product.userId)
                              .get();
                          String email = userdoc['Email'];
                          Get.to(() => ChatPage(
                              receiverEmail: email,
                              receiverID: product.userId as String));
                          print(product.userId);
                          print(email);
                        },
                        icon: const Icon(Iconsax.message, color: Colors.black),
                        label: const Text(
                          'Chat',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),

                    /// - Place Bid Box or Buy Now
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (isBid) {
                            Get.to(() => PlaceBidScreen(
                                  productId: product.productId,
                                  productPrice: product.price,
                                ));
                          } else {
                            // Handle Buy Now
                            ChatService chatService = ChatService();
                            chatService.sendPushNotification(
                                product.userId!,
                                "Your product has bought. Click here to confirm the payment",
                                product.userId!);
                            Get.to(() =>
                                PaymentScreen(productId: product.productId));
                          }
                        },
                        child: Text(
                          isBid ? 'Place Bid' : 'Buy Now',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],

                  /// - View Bids Box or Buy Now
                  if (isBid)
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => ViewBidsScreen(
                                productId: product.productId,
                              ));
                        },
                        child: const Text(
                          'View Bids',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  // if (!isBid && product.userId != currentUser?.uid)
                  //   Expanded(
                  //     child: TextButton.icon(
                  //       onPressed: () async {
                  //         DocumentSnapshot userdoc = await _firestore
                  //             .collection('Users')
                  //             .doc(product.userId)
                  //             .get();
                  //         String email = userdoc['Email'];
                  //         Get.to(() => ChatPage(
                  //             receiverEmail: email,
                  //             receiverID: product.userId as String));
                  //         print(product.userId);
                  //         print(email);
                  //       },
                  //       icon: const Icon(Iconsax.message, color: Colors.black),
                  //       label: const Text(
                  //         'Chat',
                  //         style: TextStyle(color: Colors.black),
                  //       ),
                  //     ),
                  //   ),
                  // if (!isBid && product.userId != currentUser?.uid)
                  //   Expanded(
                  //     child: TextButton(
                  //       onPressed: () {
                  //         // Handle Buy Now
                  //       },
                  //       child: const Text(
                  //         'Buy Now',
                  //         style: TextStyle(color: Colors.black),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
