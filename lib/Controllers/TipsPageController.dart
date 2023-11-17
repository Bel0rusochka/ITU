import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:math';
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
    final TipsPageModel model = TipsPageModel();
    List<Tip> tips = await model.loadDBData();
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
                color: Colors.white,
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
          const SizedBox(height: 16.0),
        ],
      );
    }).toList();
     return Column(mainAxisAlignment: MainAxisAlignment.center, children: widgets);
  }


  Future<Tip> getRandomTip() async {
    final TipsPageModel model = TipsPageModel();
    List<Tip> tips = await model.loadDBData();

    final Random random = Random();
    int randomIndex = random.nextInt(tips.length);

    return tips[randomIndex];
  }
}