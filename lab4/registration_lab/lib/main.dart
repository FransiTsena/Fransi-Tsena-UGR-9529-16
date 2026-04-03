import 'package:flutter/material.dart';
import 'package:lab2/registration.dart';

void main() => runApp(const RegistrationApp());

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const RegistrationScreen(),
    );
  }
}
