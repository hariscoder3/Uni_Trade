import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'utils/constants/colors.dart';
import 'utils/features/authentication/screens/home/home.dart';
import 'utils/features/authentication/screens/my_products/my_products.dart';
import 'utils/features/authentication/screens/profile/profile.dart';
import 'utils/features/authentication/screens/inbox/inbox.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: TColors.white,
          indicatorColor: TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(
              icon: Icon(Iconsax.shop),
              label: 'Products',
            ),
            NavigationDestination(
                icon: Icon(Iconsax.direct_inbox), label: 'Inbox'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    ProductsScreen(),
    const InboxScreen(),
    const ProfileScreen()
  ];

  // Widget getSelectedScreen() {
  //   final index = selectedIndex.value;
  //   if (index >= 0 && index < screens.length) {
  //     return screens[index];
  //   } else {
  //     return Container(color: Colors.grey);
  //   }
  // }
}
