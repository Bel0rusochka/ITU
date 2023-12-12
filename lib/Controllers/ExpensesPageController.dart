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
      int walletId, String name, num amount, int color, IconData icon, DateTime creationDate) async {
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
    // Get all expenses from the database
    List<Expense> expenses = await _model.loadDBData();

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Filter expenses for the current month
    List<Expense> expensesForCurrentMonth = expenses.where((expense) {
      return expense.creationDate.year == currentDate.year &&
          expense.creationDate.month == currentDate.month;
    }).toList();

    // Calculate the total expenses for the current month
    num totalExpensesForCurrentMonth = expensesForCurrentMonth.fold<num>(
      0.0,
          (num sum, Expense expense) => sum + expense.amount,
    );

    return totalExpensesForCurrentMonth;
  }

  //function was written by xkulin01
  Future<List<num>> calculateTotalExpensesPerDay() async {
    // Get all expenses from the database
    List<Expense> expenses = await _model.loadDBData();

    // Get the current date and time
    DateTime currentDate = DateTime.now();

    // Initialize a list to store the total expenses for each of the last 7 days
    List<num> totalExpensesPerDay = List<num>.generate(7, (index) {
      // Calculate the date for the current iteration (going back 6 days from the current date)
      DateTime date = currentDate.subtract(Duration(days: index));

      // Filter expenses for the current day
      List<Expense> expensesForDay = expenses.where((expense) {
        return expense.creationDate.year == date.year &&
            expense.creationDate.month == date.month &&
            expense.creationDate.day == date.day;
      }).toList();

      // Calculate the total expense for the current day
      num totalExpenseForDay = expensesForDay.fold<num>(
        0.0,
            (num sum, Expense expense) => sum + expense.amount,
      );

      return totalExpenseForDay;
    });

    return totalExpensesPerDay;
  }

}
