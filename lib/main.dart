import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badges/screens/screens.dart';
import 'package:badges/providers/providers.dart';
import 'package:badges/services/notification_service.dart';

void main() async { 
  final userProvider = UserProvider();
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  await userProvider.loadUser();
  runApp(
    ChangeNotifierProvider(
      create: (_) => userProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavegationProvider(),),
        ChangeNotifierProvider(create: (_) => PublicityProvider(),),
        ChangeNotifierProvider(create: (_) => BadgeProvider(),),
        ChangeNotifierProvider(create: (_) => CouponProvider(),),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Clipp',
        
        routes: {
          'home' : (_) => HomeScreen(),
          'profile' : (_) => const ValidateCellPhoneScreen(),
          'badge': (_) => const BadgesScreen(),
          'ktaxi': (_) => const KtaxiScreen(),
          'coupons': (_) => const CouponsScreen(),
          'activities': (_) => const ActivitiesScreen(),
        },
        initialRoute: 'home',
      ),
    );
  }
}