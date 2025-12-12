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
    statusBarIconBrightness: Brightness.dark,
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
        // primarySwatch: Colors.emerald,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9FAFB), // Gray-50
        fontFamily: 'Roboto', // Or your preferred font
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF10B981), // Emerald 500
          primary: const Color(0xFF059669), // Emerald 600
          secondary: const Color(0xFF047857), // Emerald 700
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

// Custom Material Color for Emerald
extension EmeraldColor on Colors {
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
      900: Color(0xFF064E3B),
    },
  );
}