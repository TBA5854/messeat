import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:flutter/material.dart';
import 'package:messeat/services/today_manu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

int hh = 0, jj = 0, messIndex = 0, hostelIndex = 0;
int kk = 1;
int debug = 0;
String j = "tttttttttttttt";
const hostels = ["Mens' Hostel", "Ladies' Hostel"];
const mess = ["Special Mess", "Veg Mess", "Non Veg Mess"];

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((pref) {
      setState(() {
        // debug = 0;
        jj = (pref.getInt("mess") ?? 1)-1 ;
        hh = (pref.getInt("hostel") ?? 1)-1 ;
        messIndex = jj ;
        hostelIndex = hh;
        pref.setInt("mess", jj+1);
        pref.setInt("hostel", hh+1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mess-Eat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose Config",
                    style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  ),
                    const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlutterToggleTab(
                    isScroll: true,
                    borderRadius: 10,
                    selectedBackgroundColors: [
                      Theme.of(context).brightness == Brightness.dark
                        ? Colors.blueGrey
                        : Colors.blueGrey
                    ],
                    unSelectedBackgroundColors: [
                      Theme.of(context).brightness == Brightness.dark
                        ? Colors.blueGrey.shade700
                        : Colors.blueGrey.shade200
                    ],
                    unSelectedTextStyle: const TextStyle(color: Colors.white),
                    selectedTextStyle: const TextStyle(color: Colors.white),
                    icons: const [Icons.boy_rounded, Icons.girl_rounded],
                    labels: hostels,
                    selectedLabelIndex: (p0) {
                      setState(() {
                      hh = p0;
                      });
                    },
                    selectedIndex: hh,
                    ),
                    const SizedBox(height: 15),
                    FlutterToggleTab(
                    borderRadius: 10,
                    selectedBackgroundColors: [
                      Theme.of(context).brightness == Brightness.dark
                        ? Colors.blueGrey
                        : Colors.blueGrey
                    ],
                    unSelectedBackgroundColors: [
                      Theme.of(context).brightness == Brightness.dark
                        ? Colors.blueGrey.shade700
                        : Colors.blueGrey.shade200
                    ],
                    unSelectedTextStyle: const TextStyle(color: Colors.white),
                    selectedTextStyle: const TextStyle(color: Colors.white),
                    isScroll: true,
                    labels: mess,
                    selectedLabelIndex: (p0) {
                      setState(() {
                      jj = p0;
                      });
                    },
                    selectedIndex: jj,
                    ),
                  ],
                  ),
                ),
              ],
            ),
            // Text('Time for a run down'),
        
            // RadioMenuButton(
            //   groupValue: 0,
            //   onChanged: (value) => 0,
            //   value: 0,
            //   child:
            // ),
            TextButton(
              child: const Icon(Icons.save),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(                      Theme.of(context).brightness == Brightness.dark
                        ? Colors.blueGrey.shade700
                        : Colors.blueGrey.shade200)
              ),
              onPressed: () {
                SharedPreferences.getInstance().then((pref) {
                  setState(() {
                    // debug = 0;
                    messIndex = jj;
                    hostelIndex = hh;
                    pref.setInt("mess", jj + 1);
                    pref.setInt("hostel", hh + 1);
                    test().then((_) {
                      if (context.mounted) {
                        // print("fired");
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog.adaptive(
                            title: const Text("Info"),
                            actions: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Your Menu has been Updated",style: TextStyle(fontSize: 15),),
                                  ),TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cool")),
                                ],
                              )
                              ],
        
                          ),
                        );
                      }
                    });
                  });
                });
              },
              onLongPress: () => setState(() {
                debug = (debug + 1) % 4;
              }),
            ),
            // TextButton(
            //     onPressed: () => test().then((_) => setState(() {})),
            //     onLongPress: () {
            //       SharedPreferences.getInstance().then((onValue) {
            //         j = onValue.getString("j")!;
            //         // j = "kk";
            //         setState(() {
            //           SharedPreferences.getInstance().then((pref) {
            //             print(j);
            //             print(pref.getInt("mess"));
            //             print(pref.getInt("hostel"));
            //           });
            //         });
            //       });
            //     },
            //     child: Text("data $kk  $j")),
            const Divider(),
            Column(
              children: [
                  const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Current Config",
                    style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  ),
                    const SizedBox(height: 15),
                Card.filled(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ListBody(
                      children: [
                       const Text("You Have Chosen "),
                        Text(hostels[hostelIndex]),
                        Text(mess[messIndex]),
                        if (debug == 3) ...[
                          Text("hh $hh"),
                          Text("jj $jj"),
                          Text("mess $messIndex"),
                          Text("hostel $hostelIndex"),
                          FutureBuilder<String?>(
                            future: SharedPreferences.getInstance()
                                .then((prefs) => prefs.getString("lastFetch")),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Text(snapshot.data ?? 'No data');
                              }
                            },
                          )
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
