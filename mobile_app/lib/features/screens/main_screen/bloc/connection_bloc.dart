import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/features/connection_handlers/bluetooth.dart';
import 'package:mobile_app/features/connection_handlers/wifi_handler.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, CarConnectionState> {
  ConnectionBloc() : super(ConnectionInitial()) {
    on<ConnectBluetooth>((event, emit) async {
      try {
        emit(PerformingConnection());

        GetIt.I<Talker>().info('Establishing bluetooth connection...');
        await GetIt.I<BluetoothConnectionHandler>().connect();

        emit(ConnectionEstablished(connectionType: 'bluetooth'));
      } catch (e) {
        emit(ConnectionFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });

    on<ConnectWifi>((event, emit) async {
      try {
        emit(PerformingConnection());

        GetIt.I<Talker>().info('Establishing wifi connection...');
        await GetIt.I<WiFiConnectionHandler>().connect();

        emit(ConnectionEstablished(connectionType: 'wifi'));
      } catch (e) {
        emit(ConnectionFailure(exception: e));
      }
    });

    on<ConnectRetry>((event, emit) {
      emit(ConnectionInitial());
    });
  }
}
