part of 'connection_bloc.dart';

abstract class ConnectionEvent extends Equatable {}

class ConnectBluetooth extends ConnectionEvent {
  ConnectBluetooth({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class ConnectWifi extends ConnectionEvent {
  ConnectWifi({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class ConnectRetry extends ConnectionEvent {
  @override
  List<Object?> get props => [];
}
