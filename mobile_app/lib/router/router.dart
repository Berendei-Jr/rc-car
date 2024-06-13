import 'package:flutter/material.dart';
import 'package:mobile_app/features/screens/control_screen/control_screen.dart';
import 'package:mobile_app/features/screens/main_screen/main_screen.dart';

final routes = {
  '/': (context) => const MainPage(title: 'RC car manager'),
  '/controller': (context) => ControllerPage(
      connectionType: ModalRoute.of(context)?.settings.arguments as String),
};
