import 'package:flutter/material.dart';

import '../Controllers/GoalsPageController.dart';
import 'GoalsPageView.dart';

class GoalsAddPageView extends StatefulWidget {
  const GoalsAddPageView({super.key, required this.title});

  final String title;

  @override
  State<GoalsAddPageView> createState() => _GoalsAddPageViewState();
}

class _GoalsAddPageViewState extends State<GoalsAddPageView>{
  final GoalsPageController _controller = GoalsPageController();


  @override
  Widget build(BuildContext context){
    String name="";
    String goalAmount="";
    String amount="";
    String date="";


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue.shade50,
        title: Text(widget.title, style: const TextStyle(fontSize: 28)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:  (){_controller.gotoPage(const GoalsPageView(title: "My Goal"), context);}, // Вызов метода _goBack при нажатии кнопки "назад"
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('Save', style: TextStyle(color: Colors.lightBlue, fontSize: 20)),
              onPressed: (){
                _controller.saveGoal(name, goalAmount, amount, date);
                _controller.gotoPage(const GoalsPageView(title: "My Goal"), context);
              }
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text){name=text;},
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text){goalAmount = text;} ,
                decoration: const InputDecoration(
                  labelText: 'Goal Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text){amount = text;} ,
                decoration: const InputDecoration(
                  labelText: 'Collected Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text){date = text;} ,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}