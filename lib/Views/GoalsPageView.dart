import 'package:flutter/material.dart';
import '../Controllers/GoalsPageController.dart';
import 'BottomNavigationBarWidgetView.dart';
import 'GoalsAddPageView.dart';

class GoalsPageView extends StatefulWidget {
  const GoalsPageView({super.key, required this.title});

  final String title;

  @override
  State<GoalsPageView> createState() => _GoalsPageViewState();
}

class _GoalsPageViewState extends State<GoalsPageView>{
  final GoalsPageController _controller = GoalsPageController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue.shade50,
        title: Text(widget.title, style: const TextStyle(fontSize: 28)),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add),
              iconSize: 35,
              onPressed: (){
                _controller.gotoPage(const GoalsAddPageView(title: "New Goal"), context);
              }
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: FutureBuilder<Column?>(
            future: _controller.drawBubbleGoal(context, 255),
            builder: (context, AsyncSnapshot<Column?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data != null) {
                return snapshot.data!;
              } else {
                return const Center(
                  child: Text('No data available'),
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}