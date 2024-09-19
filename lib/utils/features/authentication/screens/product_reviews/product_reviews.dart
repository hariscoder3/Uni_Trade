import 'package:flutter/material.dart';
import 'package:uni_trade/utils/features/authentication/screens/product_reviews/widgets/user_review_card.dart';

import '../../../../constants/sizes.dart';
import 'widgets/rating_progress_indicator.dart';
import 'widgets/progress_indicator_and_rating.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration. Replace with actual review data.
    final List<Widget> userReviews = [
      // Replace these with actual user review widgets
    ];

    return Scaffold(
      /// AppBar
      appBar: AppBar(title: const Text('Reviews & Ratings')),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ratings and reviews are verified and are from people who use the same type of device that you use.",
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Overall Product Ratings

              // Conditional rendering based on review availability
              if (userReviews.isEmpty)
                Center(
                  child: Text(
                    'No reviews',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                )
              else
                Column(
                  children: userReviews,
                ),
            ], // children
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
