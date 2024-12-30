import 'package:flutter/material.dart';
import 'Home.dart';
import 'login.dart';
import 'about_us.dart';
import 'Register.dart';

void main() {
  runApp(const CarRentalApp());
}

class CarRentalApp extends StatelessWidget {
  const CarRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/home': (context) => const Home(),
        '/about_us': (context) => const AboutUs(),
        '/register': (context) => const Register(), // Rute untuk Register
        '/login': (context) => const Login(), // Rute untuk Login
      },
    );
  }
}
