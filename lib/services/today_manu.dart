import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:home_widget/home_widget.dart';
import 'package:messeat/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

@pragma("vm:entry-point")
void callbackDispatcher() async {
  // print("something");
  Workmanager().executeTask((task, inputData) async {
    print(task);
    print(inputData);
    bool result = await test();
    if (result) {
      print("Task executed successfully");
    } else {
      print("Task execution failed");
    }
    return Future.value(result);
  });
  // print(HomeWidget.getWidgetData("Today_manu"));
}

setMenu() async {
  // print(DateTime.tryParse("2024-11-01 09:00:00"));
  late List<Day> menuList;
  var connectivity = await Connectivity().checkConnectivity();
  final prefs = await SharedPreferences.getInstance();
  var hos = prefs.getInt("hostel") ?? 1;
  var mes = prefs.getInt("mess") ?? 2;
  if (connectivity.contains(ConnectivityResult.mobile) || connectivity.contains(ConnectivityResult.wifi) || connectivity.contains(ConnectivityResult.ethernet) || connectivity.contains(ConnectivityResult.bluetooth)  ) {
  final response = await http.get(Uri.parse(
      'https://messit-server-vinnovateit.vercel.app/?hostel=${hos.toString()}&mess=${mes.toString()}'));
  if (response.statusCode == 200) {
    prefs.setString("lastFecth", response.body);
    menuList = menuSetter(response.body);}
    else{
      menuList=menuSetter(prefs.getString("lastFetch")!);  
    }
  }
else{
      menuList=menuSetter(prefs.getString("lastFetch")!);  
    }
    final now = DateTime.now();
    final todayMenu = menuList[now.day - 1];
    final tmrMenu = menuList[now.day];
    if (now.isBefore(DateTime.parse(
        "${now.year}-${now.month}-${now.day.toString().padLeft(2, '0')} 09:00:00"))) {
      prefs.setStringList(
          "today", [todayMenu.meals[0].menu, "7:00 AM - 9:00 AM", "BREAKFAST"]);
    } else if (now.isBefore(DateTime.parse(
        "${now.year}-${now.month}-${now.day.toString().padLeft(2, '0')} 14:30:00"))) {
      prefs.setStringList(
          "today", [todayMenu.meals[1].menu, "12:30 PM - 2:30 PM", "LUNCH"]);
    } else if (now.isBefore(DateTime.parse(
        "${now.year}-${now.month}-${now.day.toString().padLeft(2, '0')} 18:00:00"))) {
      prefs.setStringList(
          "today", [todayMenu.meals[2].menu, "4:30 PM - 6:00 PM", "SNACKS"]);
    } else if (now.isBefore(DateTime.parse(
        "${now.year}-${now.month}-${now.day.toString().padLeft(2, '0')} 21:00:00"))) {
      prefs.setStringList(
          "today", [todayMenu.meals[3].menu, "7:00 PM - 9:00 PM", "DINNER"]);
    } else {
      prefs.setStringList(
          "today", [tmrMenu.meals[0].menu, "7:00 AM - 9:00 AM", "BREAKFAST"]);
    }
    // print(todayMenu);
    // prefs.setStringList("today", todayMenu)
}


List<Day> menuSetter(String body) {
  List<Day> menuList = (json.decode(body)["menu"] as List)
      .map((data) => dayFromJson(data))
      .toList();
  return menuList;
}

test() async {
  try {
    // j = "hhhhhhhhhhhhh";
    await setMenu();
    print("object ${DateTime.now().toString()}");
    final prefs = await SharedPreferences.getInstance();
    final today = prefs.getStringList("today");
    prefs.setString("j", DateTime.now().toString());
    print("trig");
    if (today == null) {
      print("unable to get data");
      return;
    }
    await HomeWidget.saveWidgetData("menu", today[0]);
    await HomeWidget.saveWidgetData("time", today[1]);
    await HomeWidget.saveWidgetData("meal_type", today[2]);
    await HomeWidget.updateWidget(
        androidName: "Today_Manu"); // damn im dyslexic !?
    return Future.value(true);
  } catch (onError) {
    return Future.value(false);
  }
}

void workManagerInit() {
  Workmanager().initialize(
    callbackDispatcher, // Register the callback function for background tasks
    isInDebugMode: false, // Enable this only during development
  );
  print("registering task");
  Workmanager().registerPeriodicTask(
    "5854", // Unique task ID
    "test", // Task name
    frequency: const Duration(minutes: 15), // Update frequency
  );
}
