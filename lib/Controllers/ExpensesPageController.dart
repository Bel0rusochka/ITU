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
      int walletId, String name, int amount, int color, IconData icon, DateTime creationDate) async {
    await _model.addExpenseToDb(walletId, name, amount, color, icon, creationDate);
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

  void save(walletId, name, amount, color, icon, creationDate) {
    _model.addExpenseToDb(walletId, name, amount, color, icon, creationDate);
  }

  void edit(id, newName, newAmount, newColor, newIcon) {
    _model.editExpenseInDB(id, newName, newAmount, newColor, newIcon);
  }

  //function was written by xkulin01
  Future<num> calculateTotalExpenses() async {
    List<Expense> expenses = await _model.loadDBData();
    num totalExpenses = expenses.fold<num>(
      0,
          (num sum, Expense expense) => sum + expense.amount,
    );
    return totalExpenses;
  }

}
