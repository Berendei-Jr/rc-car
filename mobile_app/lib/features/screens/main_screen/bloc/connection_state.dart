part of 'connection_bloc.dart';

abstract class CarConnectionState extends Equatable {}

class ConnectionInitial extends CarConnectionState {
  @override
  List<Object?> get props => [];
}

class PerformingConnection extends CarConnectionState {
  @override
  List<Object?> get props => [];
}

class ConnectionEstablished extends CarConnectionState {
  ConnectionEstablished({required this.connectionType});
  final String connectionType;

  @override
  List<Object?> get props => [connectionType];
}

class ConnectionFailure extends CarConnectionState {
  ConnectionFailure({required this.exception});
  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
