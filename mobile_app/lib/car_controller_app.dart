import 'package:flutter/material.dart';
import 'package:mobile_app/router/router.dart';
import 'package:mobile_app/theme/theme.dart';

class CarControllerApp extends StatelessWidget {
  const CarControllerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto',
      theme: darkTheme,
      routes: routes,
    );
  }
}
