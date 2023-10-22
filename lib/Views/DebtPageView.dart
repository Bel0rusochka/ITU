import 'package:flutter/material.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';

class DebtPageView extends StatefulWidget {
  const DebtPageView({super.key, required this.title});

  final String title;

  @override
  State<DebtPageView> createState() => _DebtPageViewState();
}

class _DebtPageViewState extends State<DebtPageView>{
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