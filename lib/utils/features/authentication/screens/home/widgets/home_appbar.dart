// import 'package:flutter/material.dart';

// import '../../../../../../common/widgets/appbar/appbar.dart';
// import '../../../../../../common/widgets/products_cart/cart_menu_icon.dart';
// import '../../../../../constants/colors.dart';
// import '../../../../../constants/text_strings.dart';

// class THomeAppBar extends StatelessWidget {
//   const THomeAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TAppBar(
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(TTexts.homeAppbarTitle,
//               style: Theme.of(context)
//                   .textTheme
//                   .labelMedium!
//                   .apply(color: TColors.grey)),
//           Text(TTexts.homeAppbarSubTitle,
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineSmall!
//                   .apply(color: TColors.white)),
//         ],
//       ), //Column
//       actions: [TCartCounterIcon(onPressed: () {}, iconColor: TColors.white)],
//     ); //TAppBar
//   }
// }

// import 'package:flutter/material.dart';

// import '../../../../../constants/colors.dart';

// class THomeAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const THomeAppBar({super.key});

//   // const CustomAppBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: TColors.blue, // Set your desired background color
//       title: const Text(
//         "uni_trade",
//         style: TextStyle(
//             color: TColors.black,
//             fontWeight: FontWeight.bold), // Set your desired text color
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             // Handle "sell" button press here
//           },
//           child: const Text(
//             "sell",
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24), // Set your desired text color
//           ),
//         ),
//         // Add more action buttons as needed
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';

class THomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const THomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent, // Set your desired background color
      title: const Text(
        "Uni-Trade",
        style: TextStyle(
            color: TColors.black, fontSize: 25), // Set your desired text color
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0), // Set your desired padding
          child: ElevatedButton(
            onPressed: () {
              // Handle "sell" button press here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.white, // Set your desired background color
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20), // Set your desired border radius
              ),
            ),
            child: const Text(
              "sell",
              style: TextStyle(
                  color: TColors.black,
                  fontSize: 20), // Set your desired text color
            ),
          ),
        ),
        // Add more action buttons as needed
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
