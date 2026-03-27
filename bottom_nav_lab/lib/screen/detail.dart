import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go Back'),
          onPressed: () => Navigator.pop(context),
        ), // ElevatedButton
      ), // Center
    ); // Scaffold
  }
}
