import 'package:flutter/material.dart';
import 'package:muniafu_hotel/presentation/authentication/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:muniafu_hotel/presentation/home/home.dart';
import 'package:muniafu_hotel/presentation/home/widgets/bottom_nav.dart';
import 'package:muniafu_hotel/presentation/onboarding/onboarding.dart';
import 'package:muniafu_hotel/providers/booking.dart';
import 'package:muniafu_hotel/providers/hotel.dart';
import 'package:muniafu_hotel/providers/navigation.dart';
import 'core/theme/theme.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:muniafu_hotel/providers/auth.dart';
import 'presentation/authentication/screens/admin.dart';
import 'presentation/authentication/screens/login.dart';
import 'presentation/dashboard/add_hotels.dart';
import 'presentation/dashboard/widgets/bottom_nav.dart';
import 'presentation/home/profile.dart';
import 'providers/admin.dart';

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
        ChangeNotifierProvider(create: (context) => HotelProvider()),
        ChangeNotifierProvider(create: (context) => BookingProvider()),
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
      title: 'Hotel Card',
      theme: AppTheme.theme,
      home: authProvider.isLoggedIn ? BottomBar() : const SignUpScreen(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => MyHomePage(title: 'Hotel Page'),
        '/signUp': (context) => const SignUpScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/login': (context) => const LoginScreen(),
        '/admin': (context) => AdminScreen(),
        '/addHotels': (context) => const AddHotelScreen(),
        '/bottomNav': (context) => const BottomNavAdmin(),
      },
    );
  }
}