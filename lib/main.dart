import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messeat/pages/home_page.dart';
import 'package:messeat/services/today_manu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  workManagerInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueGrey, brightness: Brightness.dark),
      ),
      home: const Homepage(),
    );
  }
}
