import 'package:flutter/material.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';

class GoalsPageView extends StatefulWidget {
  const GoalsPageView({super.key, required this.title});

  final String title;

  @override
  State<GoalsPageView> createState() => _GoalsPageViewState();
}

class _GoalsPageViewState extends State<GoalsPageView>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue.shade50,
        title: Text(widget.title, style: const TextStyle(fontSize: 28)),
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}