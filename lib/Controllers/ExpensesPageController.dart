import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:itu_dev/Models/ExpensesPageModel.dart';
import 'package:itu_dev/Views/expense_item_widget.dart';

class ExpensesPageController extends ControllerMVC {
  final ExpensePageModel _model = ExpensePageModel();

  factory ExpensesPageController() {
    if (_this == null) _this = ExpensesPageController._();
    return _this;
  }

  static ExpensesPageController _this = ExpensesPageController._();
  ExpensesPageController._();

  Future<List<ExpenseItemWidget>> drawBubble(context, colorAlfa) async {
    List<Expense> expenses = await _model.loadDBData();

    List<ExpenseItemWidget> expenseWidgets = expenses.map((expense) {
      return ExpenseItemWidget(
        categoryColor: expense.color,
        categoryName: expense.name,
        categoryAmount: expense.amount,
        categoryIcon: expense.icon,
      );
    }).toList();
    return expenseWidgets;
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

  void edit(id, newName, newDate, newAmount) {
    _model.editExpenseInDB(id, newName, newAmount);
  }
}
