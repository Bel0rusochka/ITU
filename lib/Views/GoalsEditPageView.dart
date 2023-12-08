import 'package:flutter/material.dart';

import '../Controllers/GoalsPageController.dart';
import 'GoalsEditDeletePage.dart';
import 'GoalsPageView.dart';

class GoalsEditPageView extends StatefulWidget {
  const GoalsEditPageView({super.key,required this.id, required this.name,required this.goalAmount, required this.amount, required this.date});

  final id;
  final name;
  final goalAmount;
  final amount;
  final date;

  @override
  State<GoalsEditPageView> createState() => _GoalsEditPageViewState();
}

class _GoalsEditPageViewState extends State<GoalsEditPageView>{
  final GoalsPageController _controller = GoalsPageController();


  @override
  Widget build(BuildContext context){
    String newName=widget.name;
    String newGoalAmount=widget.goalAmount;
    String newAmount=widget.amount;
    String newDate=widget.date;


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue.shade50,
        title: const Text("Edit", style: TextStyle(fontSize: 28)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:  (){_controller.gotoPage(GoalsEditDeletePage(id: widget.id, name: widget.name, goalAmount: widget.goalAmount,amount: widget.amount, date: widget.date), context);}, // Вызов метода _goBack при нажатии кнопки "назад"
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('Save', style: TextStyle(color: Colors.lightBlue, fontSize: 20)),
              onPressed: (){
                print(newDate);
                _controller.edit(widget.id, newName, newGoalAmount, newAmount,  newDate);
                _controller.gotoPage(const GoalsPageView(title: "My Goals"), context);
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
                controller: TextEditingController(text: widget.name),
                onChanged: (text){newName=text;},
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: TextEditingController(text: widget.goalAmount),
                onChanged: (text){newGoalAmount = text;} ,
                decoration: const InputDecoration(
                  labelText: 'Goal Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: TextEditingController(text: widget.amount),
                onChanged: (text){newAmount = text;} ,
                decoration: const InputDecoration(
                  labelText: 'Collected Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: TextEditingController(text: widget.date),
                onChanged: (text){newDate = text;} ,
                decoration: const InputDecoration(
                  labelText: 'Desire date',
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