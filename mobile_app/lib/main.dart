import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/car_controller_app.dart';
import 'package:mobile_app/features/connection_handlers/bluetooth.dart';
import 'package:mobile_app/features/connection_handlers/wifi_handler.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started...');

  GetIt.I.registerLazySingleton<WiFiConnectionHandler>(
    () => WiFiConnectionHandler(),
  );

  GetIt.I.registerLazySingleton<BluetoothConnectionHandler>(
    () => BluetoothConnectionHandler(),
  );

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runZonedGuarded(() => runApp(const CarControllerApp()), (e, st) async {
    WidgetsFlutterBinding.ensureInitialized();

    GetIt.I<Talker>().handle(e, st);
  });
}
