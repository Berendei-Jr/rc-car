import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app/features/screens/main_screen/bloc/connection_bloc.dart';

Widget connectionSelectorButton(
    ConnectionBloc connBloc, String connectionType) {
  final String title = connectionType;

  if (title != 'Bluetooth' && title != 'Wifi') {
    throw 'Connection type not supported: $connectionType';
  }

  return ElevatedButton(
    onPressed: () async {
      final completer = Completer();
      if (connectionType == 'Bluetooth') {
        connBloc.add(ConnectBluetooth(completer: completer));
      } else if (connectionType == 'Wifi') {
        connBloc.add(ConnectWifi(completer: completer));
      }
      return completer.future;
    },
    style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
    child: SizedBox(
        width: double.infinity,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        )),
  );
}
