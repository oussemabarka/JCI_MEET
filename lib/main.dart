import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:jci_meet/Views/First_pages.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JCI Meet',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     // home: Home(),
      home:FirstView(),
      routes: <String, WidgetBuilder> {
        '/signUp': (BuildContext context) => Home(),
        '/home': (BuildContext context) => Home(),
      },
    );
  }
}




