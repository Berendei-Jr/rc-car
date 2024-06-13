import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/features/screens/main_screen/bloc/connection_bloc.dart';
import 'package:mobile_app/features/widgets/big_button.dart';
import 'package:mobile_app/features/widgets/connection_established_widget.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _connectionBloc = ConnectionBloc();

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
          title: Text(widget.title),
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
    final theme = Theme.of(context);
    return BlocBuilder<ConnectionBloc, CarConnectionState>(
        bloc: _connectionBloc,
        builder: (context, state) {
          if (state is ConnectionInitial) {
            return Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Text(
                        'Choose connection option:',
                        style: theme.textTheme.headlineMedium
                            ?.copyWith(fontSize: 24, color: Colors.white70),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      connectionSelectorButton(_connectionBloc, 'Wifi'),
                      const SizedBox(
                        height: 20,
                      ),
                      connectionSelectorButton(_connectionBloc, 'Bluetooth'),
                    ])));
          }

          if (state is PerformingConnection) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ConnectionEstablished) {
            return connectionEstablishedWidget(
                context, state.connectionType, _connectionBloc);
          }

          if (state is ConnectionFailure) {
            return Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      state.exception.toString(),
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(fontSize: 24, color: Colors.white70),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _connectionBloc.add(ConnectRetry());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Retry',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )),
                    )
                  ],
                )));
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}
