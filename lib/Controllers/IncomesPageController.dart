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

  //function was written by xkulin01
  Future<num> calculateTotalIncomes() async {
    // Get all incomes from the database
    List<Income> incomes = await _model.loadDBData();

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Filter incomes for the current month
    List<Income> incomesForCurrentMonth = incomes.where((income) {
      return income.creationDate.year == currentDate.year &&
          income.creationDate.month == currentDate.month;
    }).toList();

    // Calculate the total income for the current month
    num totalIncomesForCurrentMonth = incomesForCurrentMonth.fold<num>(
      0,
          (num sum, Income income) => sum + income.amount,
    );

    return totalIncomesForCurrentMonth;
  }

  //function was written by xkulin01
  Future<List<num>> calculateTotalIncomesPerDay() async {
    // Get all incomes from the database
    List<Income> incomes = await _model.loadDBData();

    // Get the current date and time
    DateTime currentDate = DateTime.now();

    // Initialize a list to store the total incomes for each of the last 7 days
    List<num> totalIncomesPerDay = List<num>.generate(7, (index) {
      // Calculate the date for the current iteration (going back 6 days from the current date)
      DateTime date = currentDate.subtract(Duration(days: index));

      // Filter incomes for the current day
      List<Income> incomesForDay = incomes.where((income) {
        return income.creationDate.year == date.year &&
            income.creationDate.month == date.month &&
            income.creationDate.day == date.day;
      }).toList();

      // Calculate the total income for the current day
      num totalIncomeForDay = incomesForDay.fold<num>(
        0,
            (num sum, Income income) => sum + income.amount,
      );

      return totalIncomeForDay;
    });

    return totalIncomesPerDay;
  }
}
