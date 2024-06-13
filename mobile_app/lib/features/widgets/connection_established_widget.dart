import 'package:flutter/material.dart';
import 'package:mobile_app/features/screens/main_screen/bloc/connection_bloc.dart';

Widget connectionEstablishedWidget(
    BuildContext context, String connectionType, ConnectionBloc connBloc) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.of(context).pushNamed('/controller', arguments: connectionType);
    connBloc.add(ConnectRetry());
  });
  return Container();
}
