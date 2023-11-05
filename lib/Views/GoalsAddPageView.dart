import 'package:flutter/material.dart';
import 'package:itu_dev/Views/GoalsPageView.dart';
import 'package:itu_dev/Controllers/GoalsPageController.dart';

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
    String amount="";
    String date="";
    String goalAmount="";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(widget.title, style: const TextStyle(fontSize: 28, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed:  (){_controller.gotoPage(const GoalsPageView(title: "My Goal"), context);}, // Вызов метода _goBack при нажатии кнопки "назад"
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 20)),
              onPressed: (){
                _controller.saveGoal(name, date, amount,goalAmount);
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
                style: const TextStyle(color: Colors.white),
                onChanged: (text){name=text;},
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(100, 255, 255, 255),
                  ),
                  labelText: 'Goal',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (text){goalAmount = text;} ,
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
                onChanged: (text){amount = text;} ,
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
                onChanged: (text){date = text;} ,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(100, 255, 255, 255),
                  ),
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