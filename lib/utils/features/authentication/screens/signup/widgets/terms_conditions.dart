import 'package:flutter/material.dart';
import 'package:uni_trade/utils/constants/colors.dart';
import 'package:uni_trade/utils/constants/sizes.dart';
import 'package:uni_trade/utils/constants/text_strings.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(value: true, onChanged: (value) {})),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '${TTexts.iAgreeTo}',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '${TTexts.privacyPolicy}',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: TColors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: TColors.blue,
                    )), // TextSpan
            TextSpan(text: "and", style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: TTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: TColors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: TColors.blue,
                    )), // TextSpan
          ]),
        ), //TextRich
      ],
    );
  }
}
