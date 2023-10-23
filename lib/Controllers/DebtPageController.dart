import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:itu_dev/Models/DebtPageModel.dart';
class DebtPageController extends ControllerMVC{

  factory DebtPageController(){
    if(_this == null) _this = DebtPageController._();
    return _this;
  }

  static DebtPageController _this = DebtPageController._();
  DebtPageController._();

  Future<Column> drawBubble(context) async{
    List<Widget> widgets;
    final DebtPageModel _model = DebtPageModel();
    List<Debt> debt = await _model.loadJsonData();
    widgets = debt.map((tip) {
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
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // children: <Widget>[
                  //   Text(
                  //     tip.title,
                  //     style: const TextStyle(
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  //   Text(
                  //     tip.time,
                  //     style: const TextStyle(
                  //       color: Color.fromARGB(150, 78, 77, 77),
                  //       fontSize: 12,
                  //     ),
                  //   ),
                  // ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0), // Размер пространства между контейнерами
        ],
      );
    }).toList();
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: widgets);
  }


  void gotoTextPage(pageObj, context){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => pageObj),
    );
  }
}