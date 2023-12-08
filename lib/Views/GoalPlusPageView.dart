import 'package:flutter/material.dart';

import '../Controllers/GoalsPageController.dart';
import 'BottomNavigationBarWidgetView.dart';
import 'GoalsPageView.dart';

class GoalPlusPageView extends StatefulWidget {
  const GoalPlusPageView({super.key,required this.id, required this.name,required this.goalAmount , required this.amount ,  required this.date});

/*  final String title;*/

  final id;
  final name;
  final goalAmount;
  final amount;
  final date;

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
        backgroundColor: Colors.lightBlue.shade50,
        title: const Text("Deposit", style: TextStyle(fontSize: 28)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:  (){_controller.gotoPage(const GoalsPageView(title: "My Goals"), context);},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text) {
                  newAmount = text;
                },
                decoration: const InputDecoration(
                  labelText: 'Amount to Add',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            GestureDetector(
              onTap: () async {
                if (newAmount.isNotEmpty) {
                  int amountToAdd = int.tryParse(newAmount) ?? 0;
                  int updatedAmount = int.parse(widget.amount) + amountToAdd;

                  _controller.edit(
                    widget.id,
                    widget.name,
                    widget.goalAmount,
                    updatedAmount,
                    widget.date,
                  );

                  _controller.gotoPage(
                    const GoalsPageView(title: "My Goals"),
                    context,
                  );
                }
              },
              child: Container(
                height: 45.0,
                width: 164.0,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 98, 203, 153),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add",
                            style: TextStyle(fontSize: 18),
                          ),
                        ])),
              ),
            ),
          ],

        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}