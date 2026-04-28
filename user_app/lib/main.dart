import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/assistant_methods/address_changer.dart';
import 'package:user_app/assistant_methods/cart_item_counter.dart';
import 'package:user_app/assistant_methods/total_ammount.dart';
import 'package:user_app/splashScreen/splash_screen.dart';
import 'global/global.dart';

// Modern Color Palette - Soft & Elegant
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFFF6B6B);        // Soft Coral Red
  static const Color primaryLight = Color(0xFFFF8E8E);   // Light Coral
  static const Color primaryDark = Color(0xFFE55A5A);    // Dark Coral
  
  // Secondary Colors
  static const Color secondary = Color(0xFF4ECDC4);      // Soft Teal
  static const Color secondaryLight = Color(0xFF7EDDD6); // Light Teal
  
  // Background Colors
  static const Color background = Color(0xFFF8F9FA);     // Off White
  static const Color cardBackground = Color(0xFFFFFFFF); // Pure White
  static const Color surface = Color(0xFFF1F3F4);        // Light Gray
  
  // Text Colors
  static const Color textPrimary = Color(0xFF2D3436);    // Dark Gray
  static const Color textSecondary = Color(0xFF636E72);  // Medium Gray
  static const Color textLight = Color(0xFFB2BEC3);      // Light Gray
  
  // Accent Colors
  static const Color accent = Color(0xFFFFEAA7);         // Soft Yellow
  static const Color success = Color(0xFF00B894);        // Green
  static const Color warning = Color(0xFFFDCB6E);        // Orange
  static const Color error = Color(0xFFFF7675);          // Red
  
  // Gradient Definitions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient warmGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E8E), Color(0xFFFFA3A3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient coolGradient = LinearGradient(
    colors: [Color(0xFF4ECDC4), Color(0xFF7EDDD6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartItemCounter()),
        ChangeNotifierProvider(create: (context) => TotalAmmount()),
        ChangeNotifierProvider(create: (context) => AddressChanger()),
      ],
      child: MaterialApp(
        title: 'iFood Delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.surface,
            background: AppColors.background,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: AppColors.textPrimary,
            onBackground: AppColors.textPrimary,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.cardBackground,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: AppColors.textPrimary),
            titleTextStyle: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Signatra',
            ),
          ),
          cardTheme: CardTheme(
            color: AppColors.cardBackground,
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 4,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          fontFamily: 'Train',
        ),
        home: const MySplashScreen(),
      ),
    );
  }
}
