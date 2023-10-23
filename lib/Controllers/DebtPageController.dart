import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:itu_dev/Models/DebtPageModel.dart';

class DebtPageController extends ControllerMVC{
  final DebtPageModel _model = DebtPageModel();
  factory DebtPageController(){
    if(_this == null) _this = DebtPageController._();
    return _this;
  }

  static DebtPageController _this = DebtPageController._();
  DebtPageController._();

  Future<Column> drawBubble(context) async{

    List<Widget> widgets;
    List<Debt> debts = await _model.loadDBData();
    widgets = debts.map((debt) {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => TipsTextPageView(title: "My Financial advice", text: tip.text, textTitle: tip.title)),
              // );
            },
            child: Container(
              height: 101.0,
              width: 372.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 62, 210, 94),
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
                            debt.name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            debt.amount,
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
                        "Pay off the debt before: \n${debt.date}",
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
          ),
          const SizedBox(height: 16.0),
        ],
      );
    }).toList();
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: widgets);
  }

  void gotoTextPage(pageObj, context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pageObj),
    );
  }

  void returnDebtPage(pageObj, context){
    Navigator.pop(
      context,
      MaterialPageRoute(builder: (context) => pageObj),
    );
  }

  addDebt(name, date, amount) async{
    _model.addDebtToDb(name, date, amount);
  }

  void save(name, date, amount){
    _this.addDebt(name, date, amount);
  }
}