import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:mobile_app/features/connection_handlers/wifi_handler.dart';

Widget joystick(final WiFiConnectionHandler wifiHandler, JoystickMode mode,
    Map<String, double> coordinates) {
  return Joystick(
    mode: mode,
    listener: (details) {
      if (mode == JoystickMode.horizontal) {
        coordinates['direction'] = details.x;
      } else if (mode == JoystickMode.vertical) {
        coordinates['gas'] = details.y;
      }
    },
    period: const Duration(milliseconds: 100),
  );
}
