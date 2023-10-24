import 'package:flutter/material.dart';
import 'package:itu_dev/Controllers/MainPageController.dart';
import 'package:itu_dev/Controllers/DebtPageController.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';

class MainPageView extends StatefulWidget{
  const MainPageView({super.key, required this.title});

  final String title;
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView>{
  final MainPageController _controllerMain = MainPageController();
  final DebtPageController _controllerDebt = DebtPageController();

  @override
  Widget build(BuildContext context) {
    Color color =  const Color.fromARGB(255, 128, 197, 215);
    var wightBubble = 372.0;
    var hightBubble = 171.0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue.shade50,
        title: Text(widget.title, style: const TextStyle(fontSize: 28)),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.notifications),
              iconSize: 35,
              onPressed: (){
                _controllerMain.tapNotification();
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
                          'My Goals',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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