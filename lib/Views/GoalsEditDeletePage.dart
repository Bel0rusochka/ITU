import 'package:flutter/material.dart';
import 'package:itu_dev/Controllers/GoalsPageController.dart';
import 'package:itu_dev/Views/GoalsEditPageView.dart';
import 'package:itu_dev/Views/GoalsPageView.dart';
import 'package:itu_dev/Views/GoalPlusPageView.dart';
import 'package:itu_dev/Views/GoalMinusPageView.dart';


class GoalsEditDeletePage extends StatefulWidget{
  const GoalsEditDeletePage({super.key,required this.id, required this.name, required this.goalAmount , required this.amount , required this.date});

  final id;
  final name;
  final goalAmount;
  final amount;
  final date;


  @override
  State<GoalsEditDeletePage> createState() => _GoalsEditDeletePageState();
}

class _GoalsEditDeletePageState extends State<GoalsEditDeletePage>{
  final GoalsPageController _controller = GoalsPageController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          title: const Text("Your Goal", style: TextStyle(fontSize: 28)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed:  (){_controller.gotoPage(const GoalsPageView(title: "My Goals"), context);},
          ),
        ),
        body: Center(
            child: Column(
              children: [
                Container(
                  height: 101.0,
                  width: 372.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${widget.amount}/${widget.goalAmount}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Text(
                            "Data Goal: \n${widget.date}",
                            style: const TextStyle(
                              color: Color.fromARGB(150, 78, 77, 77),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        _controller.gotoPage(GoalPlusPageView(id: widget.id, name: widget.name, goalAmount: widget.goalAmount, amount:widget.amount, date: widget.date), context);
                      },
                      child: Container(
                        height: 45.0,
                        width: 164.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  Text(
                                    "Deposit",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ]
                            )
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    GestureDetector(
                      onTap: (){
                        _controller.gotoPage(GoalMinusPageView(id: widget.id, name: widget.name,  goalAmount: widget.goalAmount, amount:widget.amount, date: widget.date), context);
                      },
                      child: Container(
                        height: 45.0,
                        width: 164.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  Text(
                                    "Withdraw",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ]
                            )
                        ),
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        _controller.gotoPage(GoalsEditPageView(id: widget.id, name: widget.name, goalAmount: widget.goalAmount, amount:widget.amount, date: widget.date), context);
                      },
                      child: Container(
                        height: 45.0,
                        width: 164.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  Text(
                                    "Edit",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(width: 9.0),
                                  Icon(Icons.edit, size: 25,)
                                ]
                            )
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    GestureDetector(
                      onTap: (){
                        _controller.dellGoal(widget.id);
                        _controller.gotoPage(const GoalsPageView(title: "My Goal"), context);
                      },
                      child: Container(
                        height: 45.0,
                        width: 164.0,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 247, 73, 73),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  Text(
                                    "Delete",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(width: 9.0),
                                  Icon(Icons.delete, size: 25,)
                                ]
                            )
                        ),
                      ),
                    ),

                  ],
                ),



              ],
            )
        )
    );
  }
}