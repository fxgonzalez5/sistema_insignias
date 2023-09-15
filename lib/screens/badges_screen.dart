import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badges/screens/screens.dart';
import 'package:badges/providers/providers.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavegationProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    Future(() => userProvider.loadUser());

    return WillPopScope(
      onWillPop: () async {
        navigationProvider.selecMenuItem = 0;
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Insignias'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: navigationProvider.pageController,
            children: [
              Badges1Screen(userProvider.loyaltyBadges),
              Badges2Screen(userProvider.usabilityBadges)
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 5,
            currentIndex: navigationProvider.selecMenuItem,
            onTap: (value) => navigationProvider.selecMenuItem = value,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.workspace_premium_outlined),
                  label: 'Fidelización'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.mobile_friendly_rounded),
                  label: 'Usabilidad'),
            ],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
          )),
    );
  }
}
