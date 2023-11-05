import 'package:flutter/material.dart';
import 'package:itu_dev/Views/GoalsAddPageView.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Controllers/GoalsPageController.dart';

class GoalsPageView extends StatefulWidget {
  const GoalsPageView({super.key, required this.title});

  final String title;

  @override
  State<GoalsPageView> createState() => _GoalsPageViewState();
}

class _GoalsPageViewState extends State<GoalsPageView>{
  final GoalsPageController _controller = GoalsPageController();

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(widget.title, style: const TextStyle(fontSize: 28, color: Colors.white)),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              iconSize: 35,
              onPressed: (){
                _controller.gotoPage(const GoalsAddPageView(title: "New Goal"), context);
              }
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}