import 'dart:async';
import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class BluetoothConnectionHandler {
  Future<void> connect() async {
    //if (await FlutterBluePlus.isSupported == false) {
    //  throw 'Bluetooth not supported';
    //}
    throw 'Bluetooth not supported yet';

    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    _adapterStateSubscription =
        FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      if (state == BluetoothAdapterState.on) {
        GetIt.I<Talker>().info('Bluetooth adapter is on');
      } else {
        GetIt.I<Talker>().info('Bluetooth adapter is off');
      }
      _adapterState = state;
    });

    GetIt.I<Talker>().info('Starting bluetooth scan...');
    var subscriptionScan = FlutterBluePlus.onScanResults.listen(
      (results) {
        if (results.isNotEmpty) {
          ScanResult r = results.last;
          GetIt.I<Talker>().info(
              '${r.device.remoteId}: "${r.advertisementData.advName}" found!');
        }
      },
      onError: (e) => GetIt.I<Talker>().error(e),
    );

    FlutterBluePlus.cancelWhenScanComplete(subscriptionScan);
  }

  void dispose() {
    _adapterStateSubscription.cancel();
  }

  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateSubscription;
}
