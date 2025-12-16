import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/splash_screen.dart';
import 'screens/language_screen.dart';
import 'screens/role_selection_screen.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/user_home_screen.dart';
import 'screens/pickup_wizard_screen.dart';
import 'screens/partner_home_screen.dart';
import 'screens/partner_payment_screen.dart';
import 'screens/payment_success_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, // Changed to light for dark backgrounds
  ));
  runApp(const TrashKariApp());
}

class TrashKariApp extends StatelessWidget {
  const TrashKariApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrashKari',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Set the background color to a very light grey/white for contrast
        scaffoldBackgroundColor: const Color(0xFFF9FAFB), 
        fontFamily: 'Roboto',
        
        // Updated ColorScheme with the Image Color
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.imageColor, // Using the new image color as seed
          primary: AppColors.imageColor,   // Main branding color
          secondary: const Color(0xFF10B981), // Lighter emerald for accents
          surface: Colors.white,
        ),
        
        // Apply the custom swatch
        primarySwatch: AppColors.emerald, 
        
        // Customizing AppBar to match the new theme
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.imageColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        
        // Customizing Buttons to use the new color
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.imageColor,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/language': (context) => const LanguageScreen(),
        '/role': (context) => const RoleSelectionScreen(),
        '/login': (context) => const LoginScreen(),
        '/otp': (context) => const OtpScreen(),
        '/user_home': (context) => const UserHomeScreen(),
        '/pickup_wizard': (context) => const PickupWizardScreen(),
        '/partner_home': (context) => const PartnerHomeScreen(),
        '/partner_payment': (context) => const PartnerPaymentScreen(),
        '/payment_success': (context) => const PaymentSuccessScreen(),
      },
    );
  }
}

class AppColors {
  // ✅ The exact Deep Forest Green from the 'app s 1.jpg' image
  static const Color imageColor = Color(0xFF064E3B); 

  static const MaterialColor emerald = MaterialColor(
    0xFF10B981,
    <int, Color>{
      50: Color(0xFFECFDF5),
      100: Color(0xFFD1FAE5),
      200: Color(0xFFA7F3D0),
      300: Color(0xFF6EE7B7),
      400: Color(0xFF34D399),
      500: Color(0xFF10B981),
      600: Color(0xFF059669),
      700: Color(0xFF047857),
      800: Color(0xFF065F46),
      900: Color(0xFF064E3B), // Matches imageColor
    },
  );
}