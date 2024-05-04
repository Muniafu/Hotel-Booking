// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:muniafu_hotel/presentation/authentication/screens/signup.dart';
import 'package:muniafu_hotel/presentation/home/home_screen.dart';
import 'package:muniafu_hotel/presentation/home/widgets/bottom_nav.dart';
import 'package:muniafu_hotel/presentation/onboarding/onboarding_screen.dart';
import 'package:muniafu_hotel/providers/auth_provider.dart';
import 'package:muniafu_hotel/providers/navigation_provider.dart';

import 'firebase_options.dart';
import 'presentation/authentication/screens/admin.dart';
import 'presentation/authentication/screens/login.dart';
import 'presentation/home/add_hotels_screen.dart';
import 'presentation/home/profile_screen.dart';
import 'providers/admin_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(
          create: (context) => AdminProvider(),
        ),
      ],
      child: const Hotel(),
    ),
  );
}

class Hotel extends StatelessWidget {
  const Hotel({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muniafu Hotel',
      theme: AppTheme.theme,
      home: authProvider.isLoggedIn ? BottomBar() : const SignUpScreen(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const MyHomePage(title: 'Hotel Page'),
        '/signUp': (context) => const SignUpScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/login': (context) => const LoginScreen(),
        '/admin': (context) => AdminScreen(),
        '/addHotels': (context) => const AddHotelScreen(),
      },
    );
  }
}

class AppTheme {
  static var theme;
}