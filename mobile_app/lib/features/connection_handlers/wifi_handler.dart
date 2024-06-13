import 'dart:io';
import 'dart:convert' show utf8;

import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

//const RaspberryPiAddress = '10.42.0.1';
const RaspberryPiAddress = '192.168.1.73';
const RaspberryPiPort = 15556;
const RaspberryPiHotspot = 'Zero2W';

class CarCommand {
  CarCommand(final double gasValue, final double directionValue) {
    _gasValue = 255 - ((gasValue + 1) * 127.5).toInt();
    _directionValue = ((directionValue + 1) * 127.5).toInt();
  }

  @override
  String toString() {
    return "{Gas: $_gasValue, Direction: $_directionValue}";
  }

  late int _gasValue;
  late int _directionValue;
}

class WiFiConnectionHandler {
  Future<void> connect() async {
    try {
      socket = await Socket.connect(RaspberryPiAddress, RaspberryPiPort,
          timeout: const Duration(seconds: 3));
    } catch (e) {
      GetIt.I<Talker>().error(e);
      throw StateError(
          'Unable to connect to car controller. Make sure you are connected to "$RaspberryPiHotspot" hotspot');
    }
    Talker().info(
        'Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
    socket.writeln('Hello from mobile app!');

    //socket.listen((data) {
    //  Talker().info('Received: ${utf8.decode(data)}');
    //});
  }

  Future<void> send(CarCommand command) async {
    GetIt.I<Talker>().info('Sending: $command');
    socket.write(command.toString());
  }

  Future<void> disconnect() async {
    Talker().info('Closing connection');
    socket.close();
  }

  late Socket socket;
}
