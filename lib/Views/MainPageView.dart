import 'package:flutter/material.dart';
import 'package:itu_dev/Controllers/GoalsPageController.dart';
import 'package:itu_dev/Controllers/MainPageController.dart';
import 'package:itu_dev/Controllers/DebtPageController.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Views/NotificationsPageView.dart';
import 'package:itu_dev/Views/NotificationsPageView.dart';

class MainPageView extends StatefulWidget{
  const MainPageView({super.key, required this.title});

  final String title;
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView>{
  final MainPageController _controllerMain = MainPageController();
  final DebtPageController _controllerDebt = DebtPageController();
  final GoalsPageController _controllerGoal = GoalsPageController();

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    var wightBubble = 372.0;
    var hightBubble = 171.0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(widget.title, style: const TextStyle(fontSize: 28, color: Colors.white)),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              iconSize: 35,
              onPressed: (){
                _controllerMain.gotoPage(const NotificationsPageView(title: "My Notifications"), context);
              }
          )
        ],
      ),
      body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: hightBubble,
                  width: wightBubble,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'My Total',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  height: hightBubble,
                  width: wightBubble,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'My Balance',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  height: hightBubble,
                  width: wightBubble,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Balance - Last 7 days',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                _controllerMain.getGoalPartMain(hightBubble, wightBubble, color, _controllerGoal, context),
                const SizedBox(height: 7),
                _controllerMain.getDebtPartMain(hightBubble, wightBubble, color, _controllerDebt, context),
                const SizedBox(height: 7),
              ],
            ),
          )
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}