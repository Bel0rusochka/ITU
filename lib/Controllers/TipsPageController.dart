import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:itu_dev/Models/TipsPageModel.dart';
import 'package:itu_dev/Views/TipsTextPageView.dart';
class TipsPageController extends ControllerMVC{

  factory TipsPageController(){
    if(_this == null) _this = TipsPageController._();
    return _this;
  }

  static TipsPageController _this = TipsPageController._();
  TipsPageController._();

  Future<Column> drawBubble(context) async{
    List<Widget> widgets;
    final TipsPageModel _model = TipsPageModel();
    List<Tip> tips = await _model.loadJsonData();
    widgets = tips.map((tip) {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TipsTextPageView(title: "My Financial advice", text: tip.text, textTitle: tip.title)),
              );
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
                  children: <Widget>[
                    Text(
                      tip.title,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      tip.time,
                      style: const TextStyle(
                        color: Color.fromARGB(150, 78, 77, 77),
                        fontSize: 12,
                      ),
                    ),
                  ],
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