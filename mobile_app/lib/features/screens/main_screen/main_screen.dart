import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Choose connection option:',
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontSize: 24, color: Colors.white70),
            ),
            Text(
              'Please try again later',
              style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
            ),
            const SizedBox(
              height: 30,
            ),
            OutlinedButton(
                onPressed: () {
                  _cryptoListBloc.add(LoadCryptoList());
                },
                child: const Text(
                  'Try again',
                  style: TextStyle(color: Colors.yellow),
                ))
          ],
        )));
  }
}
