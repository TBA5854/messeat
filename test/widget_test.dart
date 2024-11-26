// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:messeat/main.dart';

// import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:messeat/models/model.dart';
// import 'package:http/http.dart';

Future<void> main() async {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });4
  final response = await http.get(Uri.parse(
      'https://messit-server-vinnovateit.vercel.app/?hostel=1&mess=2'));

  if (response.statusCode == 200) {
    // print(response.body);
    List<Day> menuList = (json.decode(response.body)["menu"] as List)
        .map((data) => dayFromJson(data))
        .toList();
    // final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final todayMenu = menuList[now.day - 1];
    print(todayMenu.meals);
    // print(DateTime.parse(todayMenu.date));
    // prefs.setStringList("today", todayMenu)
  }
}
