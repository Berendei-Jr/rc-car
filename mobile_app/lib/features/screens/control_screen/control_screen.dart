import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/features/connection_handlers/wifi_handler.dart';
import 'package:mobile_app/features/widgets/joystic.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ControllerPage extends StatefulWidget {
  ControllerPage({super.key, required String connectionType}) {
    if (connectionType == 'wifi') {
      _title = 'Wifi controller';
    } else if (connectionType == 'bluetooth') {
      _title = 'Bluetooth controller';
    } else {
      GetIt.I<Talker>().error('Invalid connection type $connectionType');
      _title = '';
    }
  }

  late final String _title;
  late final Timer _timer;
  final _wifiConnectionHandler = GetIt.I<WiFiConnectionHandler>();

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    widget._timer = Timer.periodic(
        const Duration(milliseconds: 100),
        (Timer t) => setState(() {
              if (_coordinates['gas'] == _previousCoordinates['gas'] &&
                  _coordinates['direction'] ==
                      _previousCoordinates['direction']) {
                return;
              }
              _previousCoordinates['gas'] = _coordinates['gas'] as double;
              _previousCoordinates['direction'] =
                  _coordinates['direction'] as double;
              sendCoordinates();
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 65, 64, 70),
          ])),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget._title),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TalkerScreen(
                      talker: GetIt.I<Talker>(),
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.document_scanner_outlined,
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: _page(context),
      ),
    );
  }

  Widget _page(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            joystick(widget._wifiConnectionHandler, JoystickMode.vertical,
                _coordinates),
            const SizedBox(
              width: 300,
            ),
            joystick(widget._wifiConnectionHandler, JoystickMode.horizontal,
                _coordinates),
          ],
        )
      ],
    ));
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    widget._timer.cancel();
    super.dispose();
  }

  Future<void> sendCoordinates() async {
    widget._wifiConnectionHandler.send(CarCommand(
        _coordinates['gas'] as double, _coordinates['direction'] as double));
  }

  final Map<String, double> _coordinates = {
    'gas': 0,
    'direction': 0,
  };
  final Map<String, double> _previousCoordinates = {
    'gas': 0,
    'direction': 0,
  };
}
