import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
class TipsPageController extends ControllerMVC{

  factory TipsPageController(){
    if(_this == null) _this = TipsPageController._();
    return _this;
  }

  static TipsPageController _this = TipsPageController._();
  TipsPageController._();

  void gotoTextPage(pageObj, context){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => pageObj),
    );
  }

}