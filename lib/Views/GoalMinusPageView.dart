import 'package:flutter/material.dart';
import 'package:itu_dev/Controllers/GoalsPageController.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Views/GoalsPageView.dart';
class GoalMinusPageView extends StatefulWidget {
  const GoalMinusPageView({super.key,required this.id, required this.name, required this.amount , required this.goalAmount , required this.date});

/*  final String title;*/

  final id;
  final name;
  final amount;
  final date;
  final goalAmount;
  @override
  State<GoalMinusPageView> createState() => _GoalMinusPageViewState();
}
class _GoalMinusPageViewState extends State<GoalMinusPageView>{
  final GoalsPageController _controller = GoalsPageController();
  @override
  Widget build(BuildContext context){
    String newAmount=widget.amount;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: const Text("Withdraw", style: TextStyle(fontSize: 28, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed:  (){_controller.gotoPage(const GoalsPageView(title: "My Goals"), context);},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (text){newAmount=text;},
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Color.fromARGB(100, 255, 255, 255)),
                  border: OutlineInputBorder(),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(100, 255, 255, 255)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(100, 255, 255, 255)),
                  ),
                  labelText: 'Amount to Deduct',
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            GestureDetector(
              onTap: () async {
                if (newAmount.isNotEmpty) {
                  int amountToDeduct = int.tryParse(newAmount) ?? 0;
                  int updatedAmount = int.parse(widget.amount) - amountToDeduct;

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
                  color: const Color.fromARGB(255, 194, 124, 156),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text(
                            "Deduct",
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