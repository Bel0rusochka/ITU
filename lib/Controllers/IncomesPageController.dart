import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:itu_dev/Models/IncomesPageModel.dart';


class IncomesPageController extends ControllerMVC {
  final IncomesPageModel _model = IncomesPageModel();

  factory IncomesPageController() {
    return _this;
  }

  static final IncomesPageController _this = IncomesPageController._();

  IncomesPageController._();


  Future<void> addIncomeToDb(
      int walletId, String name, int amount, int color, IconData icon, DateTime creationDate) async {
    await _model.addIncomeToDb(walletId, name, amount, color, icon, creationDate);
  }

  Future<List<Income>> drawBubble(context, colorAlfa) async {
    return _model.loadDBData();
  }

  void gotoPage(pageObj, context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => pageObj),
    );
  }

  void dellIncome(id) {
    _model.deleteIncomeFromDB(id);
  }

  void save(walletId, name, amount, color, icon, creationDate) {
    _model.addIncomeToDb(walletId, name, amount, color, icon,creationDate);
  }

  void edit(id, newName, newAmount, newColor, newIcon) {
    _model.editIncomeInDB(id, newName, newAmount, newColor, newIcon);
  }
}
