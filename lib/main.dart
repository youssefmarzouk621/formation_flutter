import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:revision/Views/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (BuildContext context) {
          return HomePage();
        },
      },
      initialRoute: "/",
      //home: HomePage(),
      builder: EasyLoading.init(),
    );
  }
}
