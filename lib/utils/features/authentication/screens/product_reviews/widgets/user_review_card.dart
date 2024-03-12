import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../../common/widgets/products/rating/rating_indicator.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user/user.png")),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text('Harris Ellahi',
                    style: Theme.of(context).textTheme.titleLarge),
              ], //Children
            ), // Row
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ], //Children
        ), // Row
        const SizedBox(height: TSizes.spaceBtwItems),

        ///Review
        Row(
          children: [
            const TRatingBarIndicator(rating: 4),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('01 Nov, 2023', style: Theme.of(context).textTheme.bodyMedium),
          ], // Children
        ), // Row

        const SizedBox(height: TSizes.spaceBtwItems),

        const ReadMoreText(
          'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primary),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primary),
        ), // ReadMoreText
        const SizedBox(height: TSizes.spaceBtwSections),
      ], //Children
    ); // Column
  }
}
