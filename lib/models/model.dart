// import 'dart:convert';

class Day {
  List<Meal> meals;
  String date;
  Day({required this.meals, required this.date});
}

class Meal {
  int id;
  String menu;
  Meal({required this.id, required this.menu});
}

Meal mealFromJson(Map<String, dynamic> json) {
  // print(json);
  return Meal(id: json['id'], menu: json['menu']);
}

Day dayFromJson(Map<String, dynamic> txt) {
  // print(txt);
  /*
      List<Day> test = (json.decode(response.body)["menu"] as List)
        .map((data) => dayFromJson(data))
        .toList();
         */
  return Day(
    meals: (txt['menu'] as List).map((data) => Meal(id: data['type'], menu: data['menu'])).toList(),
    date: txt['date'],
  );
}

//?hostel=1&mess=2 
//hostel 1 - men 2 - ladies
//mess 1 - special 2 - veg 3 - non-veg
//meal 1 - breakfast 2 - lunch 3 - snacks 4 - dinner
