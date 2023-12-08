import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import '../Models/GoalsPageModel.dart';
import '../Views/GoalsEditDeletePage.dart';

class GoalsPageController extends ControllerMVC{
  final GoalsPageModel _model = GoalsPageModel();
  factory GoalsPageController(){
    _this ??= GoalsPageController._();
    return _this;
  }

  static GoalsPageController _this = GoalsPageController._();
  GoalsPageController._();

  Future<Column> drawBubbleGoal(context, colorAlfa) async{
    List<Widget> widgets;
    List<Goal> goals = await _model.loadDBData();
    widgets = goals.map((goal) {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              _this.gotoPage(GoalsEditDeletePage(id: goal.id, name: goal.name, goalAmount: goal.goalAmount, amount: goal.amount, date: goal.date), context);
            },
            child: _this.drawContainerGoals(101.0,372.0, colorAlfa, goal),
          ),
          const SizedBox(height: 16.0),
        ],
      );
    }).toList();
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: widgets);
  }

  Future<Column> drawGoalsForMain(colorAlfa) async{
    List<Widget> widgets;
    List<Goal> goals = await _model.loadDBData();
    widgets = goals.map((goal) {
      return Column(
        children: [
          _this.drawContainerGoals(60.0, 372.0, colorAlfa, goal),
          const SizedBox(height: 3.0),
        ],
      );
    }).toList();
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: widgets);
  }

  void gotoPage(pageObj, context){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => pageObj),
    );
  }

  Container drawContainerGoals(height,width, colorAlfa, goal){

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Color.fromARGB(colorAlfa, 128, 197, 215),
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
                    goal.name,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "${goal.amount}/${goal.goalAmount}",
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
                "Data Goal: ${goal.date}",
                style: const TextStyle(
                  color: Color.fromARGB(150, 78, 77, 77),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void dellGoal(id){
    _model.dellGoalFromDB(id);
  }
  void saveGoal(name,goalAmount, amount,  date){
    _model.addGoalToDb(name, goalAmount, amount,date);
  }

  void edit(id, newName, newGoalAmount, newAmount, newDate){
    _model.editGoalInDB(id, newName, newGoalAmount, newAmount,  newDate);
  }
}