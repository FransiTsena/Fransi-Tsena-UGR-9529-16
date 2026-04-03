import 'package:flutter/material.dart';
import 'package:go_demo/routes.dart';

void main() {
  runApp(const GoDemoApp());
}

class GoDemoApp extends StatelessWidget {
  const GoDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: routes,
    );
  }
}
