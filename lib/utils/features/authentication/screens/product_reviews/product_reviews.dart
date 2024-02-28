import 'package:flutter/material.dart';
import 'package:uni_trade/utils/features/authentication/screens/product_reviews/widgets/user_review_card.dart';

import '../../../../../common/widgets/products/rating/rating_indicator.dart';
import '../../../../constants/sizes.dart';
import 'widgets/rating_progress_indicator.dart';

//progressindicatorandrating.dart, rating_progress_indidcator.dart,rating-indicator.dart, user_review_card.dart,

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: AppBar(title: const Text('Reviews & Ratings')),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Ratings and reviews are verified and are from people who use the same type of device that you use."),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Overall Product Ratings
              const TOverallProductRating(),
              const TRatingBarIndicator(rating: 3.5),
              Text("12,611", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///User reviews list
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ], // children
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
