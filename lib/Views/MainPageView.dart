import 'package:flutter/material.dart';
import 'package:itu_dev/Controllers/MainPageController.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';

class MainPageView extends StatefulWidget{
  const MainPageView({super.key, required this.title});

  final String title;
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView>{
  final MainPageController _controller = MainPageController();

  @override
  Widget build(BuildContext context) {
    Color color =  const Color.fromARGB(255, 181, 198, 224);
    var wightBubble = 372.0;
    var hightBubble = 171.0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue.shade50,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.notifications),
              iconSize: 35,
              onPressed: (){
                _controller.tapNotification();
              }
          )
        ],
        title: Text(widget.title, style: const TextStyle(fontSize: 28)),
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
                          'My Debts',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 7),
              ],
            ),
          )
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}