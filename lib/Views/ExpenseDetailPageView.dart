import 'package:flutter/material.dart';
import 'package:itu_dev/Models/BalancePageModel.dart';
import 'package:itu_dev/Views/EditExpensePageView.dart';
import '../Controllers/ExpensesPageController.dart';
import '../Models/ExpensesPageModel.dart';
import 'DepositPageView.dart';
import 'ExpensesPageView.dart';
import 'WithdrawPageView.dart';

class ExpenseDetailsPageView extends StatelessWidget {
  final Expense expense;
  final Balance balance;
  final int walletId;
  final String title;

  ExpenseDetailsPageView({Key? key, required this.expense, required this.walletId, required this.balance, required this.title}) : super(key: key);

  final ExpensesPageController _controller = ExpensesPageController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
    final ButtonStyle deleteButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 247, 73, 73),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF575093),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            _controller.gotoPage(ExpensesPageView(title: title, walletId: walletId, balance: balance),context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: const Alignment(0.0, -0.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                color: Color(expense.color),
                child: SizedBox(
                  height: 80.0,
                  child: ListTile(
                    contentPadding:
                    const EdgeInsets.only(left: 25.0, right: 22.0, top: 15.0),
                    title: Text(
                      expense.name,
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    trailing: Text(
                      expense.amount.toString(),
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    style: buttonStyle,
                  onPressed: () {
                    _controller.gotoPage(DepositPageView(expense: expense, balance: balance, walletId: walletId, title: title,), context);
                  },
                    child: const Text('Deposit +'),
                  ),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      _controller.gotoPage(WithdrawPageView(expense: expense, balance: balance, walletId: walletId, title: title,), context);
                    },
                    child: const Text('Withdraw −'),
                  ),
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton.icon(
                    style: buttonStyle,
                  onPressed: () {
                    _controller.gotoPage(EditExpensePageView(expense: expense, balance: balance, walletId: walletId, title: title,), context);
                  },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                  ElevatedButton.icon(
                    style: deleteButtonStyle,
                    onPressed: () {
                      _controller.dellExpense(expense.id);

                      _controller.gotoPage(ExpensesPageView(title: title,balance: balance, walletId: walletId),context);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
