import 'package:flutter/material.dart';
import 'package:itu_dev/Views/GoalsPageView.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Controllers/GoalsPageController.dart';
import 'package:itu_dev/Views/GoalsEditDeletePage.dart';
class GoalPlusPageView extends StatefulWidget {
  const GoalPlusPageView({super.key,required this.id, required this.name, required this.amount , required this.goalAmount , required this.date});

/*  final String title;*/

  final id;
  final name;
  final amount;
  final date;
  final goalAmount;
  @override
  State<GoalPlusPageView> createState() => _GoalPlusPageViewState();
}
class _GoalPlusPageViewState extends State<GoalPlusPageView>{
  final GoalsPageController _controller = GoalsPageController();
    @override
    Widget build(BuildContext context){
      String newAmount=widget.amount;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          backgroundColor: const Color.fromARGB(255, 87, 80, 147),
          title: const Text("Deposit", style: TextStyle(fontSize: 28, color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed:  (){_controller.gotoPage(GoalsEditDeletePage(id: widget.id, name: widget.name, amount: widget.amount, date: widget.date, goalAmount: widget.goalAmount), context);},
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [
                Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (text){newAmount=text;},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
               ),
                const SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: (){
                      _controller.gotoPage(const GoalsPageView(title: "My Goals"), context);
                    },
                    child: Container(
                    height: 45.0,
                    width: 164.0,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255,98, 203, 153),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Text(
                                "Add",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]
                        )
                    ),
                  ),
                  ),
    ],

    ),
          ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}