import 'package:flutter/material.dart';
import 'package:go_demo/routes.dart';

void main() {
  runApp(const GoPathApp());
}

class GoPathApp extends StatelessWidget {
  const GoPathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: routes,
    );
  }
}
