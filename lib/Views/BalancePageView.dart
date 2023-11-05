import 'package:flutter/material.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';

class BalancePageView extends StatefulWidget {
  const BalancePageView({super.key, required this.title});

  final String title;

  @override
  State<BalancePageView> createState() => _BalancePageViewState();
}


class _BalancePageViewState extends State<BalancePageView>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(widget.title, style: const TextStyle(fontSize: 28, color: Colors.white)),
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}