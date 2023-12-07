/*
===========================================================================
  Author: xkulin01
  Description: Controller for main page
===========================================================================
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itu_dev/Views/DebtPageView.dart';
import 'package:itu_dev/Views/GoalsPageView.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MainPageController extends ControllerMVC{

  factory MainPageController(){
    if(_this == null) _this = MainPageController._();
    return _this;
  }

  static MainPageController _this = MainPageController._();
  MainPageController._();

  //use for navigate from main page for other
  void gotoPage(pageObj, context){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => pageObj),
    );
  }

  //draw all debt on the main page
  GestureDetector getDebtPartMain(hightBubble, wightBubble, color, controllerDebt, context){
    return GestureDetector(
        onTap: (){controllerDebt.gotoPage(const DebtPageView(title: "My Debt"), context);},
        child: Container(
          height: hightBubble,
          width: wightBubble,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'My Debts',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Expanded(
                child: FutureBuilder<Column?>(
                  future: controllerDebt.drawDebtForMain(0),
                  builder: (context, AsyncSnapshot<Column?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return ListView(
                        children: [snapshot.data!],
                      );
                    } else {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        )
      );
  }

  //draw all goal on the main page
  GestureDetector getGoalPartMain(hightBubble, wightBubble, color, controllerGoal, context){
    return GestureDetector(
        onTap: (){controllerGoal.gotoPage(const GoalsPageView(title: "My Goals"), context);},
        child: Container(
          height: hightBubble,
          width: wightBubble,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'My Goals',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Expanded(
                child: FutureBuilder<Column?>(
                  future: controllerGoal.drawGoalsForMain(0),
                  builder: (context, AsyncSnapshot<Column?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return ListView(
                        children: [snapshot.data!],
                      );
                    } else {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        )
    );
  }


}