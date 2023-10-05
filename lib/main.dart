import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shell/repository/car_provider.dart';
import 'package:flutter_shell/repository/history_provider.dart';
import 'package:flutter_shell/screens/initial_screen.dart';

void main() {
  // É necessário estabelecer os providers (gerenciamento de estados) como
  // Widget "pai" do aplicativo.
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CarSpecs()),
    ChangeNotifierProvider(create: (context) => MaintenanceHistory()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Commander',
        theme: ThemeData(primarySwatch: Colors.yellow),
        home: const InitialScreen());
  }
}
