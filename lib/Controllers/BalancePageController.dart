import 'package:itu_dev/Views/SpecificWalletView.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';

import '../Models/BalancePageModel.dart';
import '../Models/ExpensesPageModel.dart';
import '../Models/IncomesPageModel.dart';

class BalancePageController extends ControllerMVC {
  final BalancePageModel _model = BalancePageModel();
  final ExpensePageModel _expenseModel = ExpensePageModel();
  final IncomesPageModel _incomesModel = IncomesPageModel();
  factory BalancePageController() {
    _this ??= BalancePageController._();
    return _this;
  }

  static BalancePageController _this = BalancePageController._();
  BalancePageController._();

  late num totalAmount = 0; // Declare totalAmount as a num variable

  Future<Widget> drawBubbleBalance(context, colorAlfa) async {
    List<Balance> balances = await _model.loadDBData();
    return Padding(
      padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 2,
        ),
        itemCount: balances.length,
        itemBuilder: (context, index)  {
          Balance balance = balances[index];
          return GestureDetector(
            onTap: () {
              _this.gotoPage(SpecificWalletView(title: balance.name, balance: balance, walletId: balance.id), context);
            },
            child: _this.drawContainerBalance(50.0, 170.0, colorAlfa, balance),
          );
        },
      ),
    );
  }


  Future<num> calculateTotalAmount() async {
    List<Balance> balances = await _model.loadDBData();
    num calculatedTotalAmount = balances.fold<num>(
      0,
          (num sum, Balance balance) => sum + (double.tryParse(balance.amount) ?? 0),
    );
    return calculatedTotalAmount;
  }

  Future<void> updateTotalAmount() async {
    totalAmount = await calculateTotalAmount();
    setState(() {});
  }

  Future<Column> drawBalanceForMain(colorAlfa) async {
    List<Widget> widgets;
    List<Balance> balances = await _model.loadDBData();
    widgets = balances.map((balance) {
      return Column(
        children: [
          _this.drawContainerBalance(60.0, 372.0, colorAlfa, balance),
          const SizedBox(height: 3.0),
        ],
      );
    }).toList();
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: widgets);
  }

  void gotoPage(pageObj, context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => pageObj),
    );
  }

  Container drawContainerBalance(height, width, colorAlfa, balance) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Color.fromARGB(colorAlfa, 128, 197, 215),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              balance.name,
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center, // Center text within the container
            ),
            const SizedBox(height: 3.0),
            Text(
              "${balance.amount}\$",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void dellBalance(id) {
    _model.dellBalanceFromDB(id);
  }

  void saveBalance(name, amount) {
    _model.addBalanceToDb(name, amount).then((_) {
      updateTotalAmount(); // Update totalAmount immediately after saving
    });
  }

  void edit(id, newName, newAmount) {
    _model.editBalanceInDB(id, newName, newAmount).then((_) {
      updateTotalAmount(); // Update totalAmount immediately after editing
    });
  }
}
