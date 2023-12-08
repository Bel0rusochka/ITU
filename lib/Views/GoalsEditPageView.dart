import 'package:flutter/material.dart';
import 'package:itu_dev/Views/GoalsPageView.dart';
import 'package:itu_dev/Views/GoalsEditDeletePage.dart';
import 'package:itu_dev/Controllers/GoalsPageController.dart';

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
        title: const Text("Edit", style: TextStyle(fontSize: 28)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed:  (){_controller.gotoPage(GoalsEditDeletePage(id: widget.id, name: widget.name, goalAmount: widget.goalAmount,amount: widget.amount, date: widget.date), context);},
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 20)),
              onPressed: (){
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
                style: const TextStyle(color: Colors.white),
                controller: TextEditingController(text: widget.name),
                onChanged: (text){newName=text;},
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(100, 255, 255, 255),
                  ),
                  labelText: 'Name of goal',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: TextEditingController(text: widget.goalAmount),
                onChanged: (text){newGoalAmount = text;} ,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(100, 255, 255, 255),
                  ),
                  labelText: 'Goal Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: TextEditingController(text: widget.amount),
                onChanged: (text){newAmount = text;} ,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(100, 255, 255, 255),
                  ),
                  labelText: 'Collected Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: TextEditingController(text: widget.date),
                onChanged: (text){newDate = text;} ,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(100, 255, 255, 255),
                  ),
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