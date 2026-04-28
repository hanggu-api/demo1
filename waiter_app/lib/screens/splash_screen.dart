import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waiter_app/screens/login_screen.dart';
import 'package:waiter_app/screens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      checkAuthentication();
    });
  }

  void checkAuthentication() async {
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      // Verificar se é garçom
      DocumentSnapshot waiterDoc = await FirebaseFirestore.instance
          .collection('waiters')
          .doc(user.uid)
          .get();
      
      if (waiterDoc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => const HomeScreen()),
        );
      } else {
        // Não é garçom, fazer logout
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => const LoginScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant,
              size: 120,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'App Garçom',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Comanda Digital',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
