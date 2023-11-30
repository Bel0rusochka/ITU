import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:itu_dev/Models/ExpensesPageModel.dart';


class ExpensesPageController extends ControllerMVC {
  final ExpensePageModel _model = ExpensePageModel();

  factory ExpensesPageController() {
    return _this;
  }

  static final ExpensesPageController _this = ExpensesPageController._();

  ExpensesPageController._();


  Future<void> addExpenseToDb(
      String name, int amount, int color, IconData icon) async {
    await _model.addExpenseToDb(name, amount, color, icon);
  }

  Future<List<Expense>> drawBubble(context, colorAlfa) async {
    return _model.loadDBData();
  }

  void gotoPage(pageObj, context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => pageObj),
    );
  }

  void dellExpense(id) {
    _model.deleteExpenseFromDB(id);
  }

  void save(name, amount, color, icon) {
    _model.addExpenseToDb(name, amount, color, icon);
  }

  void edit(id, newName, newAmount, newColor, newIcon) {
    _model.editExpenseInDB(id, newName, newAmount, newColor, newIcon);
  }
}
