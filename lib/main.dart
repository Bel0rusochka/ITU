import 'package:flutter/material.dart';
import 'package:itu_dev/Views/MainPageView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ITU proj',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 87, 80, 147),
          iconTheme: IconThemeData(color: Colors.white)
        ),
        scaffoldBackgroundColor : Color.fromARGB(255, 87, 80, 147),
        fontFamily: "MiriamLibre",
        useMaterial3: true,
      ),

      home: const MainPageView(title: 'Hello,\nUser!'),
    );
  }
}

