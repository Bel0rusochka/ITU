import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itu_dev/Models/BalancePageModel.dart';
import 'package:itu_dev/Models/ExpensesPageModel.dart';
import '../Controllers/ExpensesPageController.dart';
import 'BottomNavigationBarWidgetView.dart';
import 'ExpensesPageView.dart';

class WithdrawPageView extends StatefulWidget {
  final Expense expense;
  final int walletId;
  final Balance balance;

  const WithdrawPageView({Key? key, required this.expense, required this.walletId, required this.balance}) : super(key: key);

  @override
  State<WithdrawPageView> createState() => _WithdrawPageViewState();
}

class _WithdrawPageViewState extends State<WithdrawPageView> {
  final ExpensesPageController _controller = ExpensesPageController();
  String newAmount = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: const Color.fromARGB(255, 87, 80, 147),
        title: const Text("Withdraw", style: TextStyle(fontSize: 28, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (text) {
                  newAmount = text;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            GestureDetector(
              onTap: () async {
                if (newAmount.isNotEmpty) {
                  int amountToWithdraw = int.tryParse(newAmount) ?? 0;
                  amountToWithdraw = widget.expense.amount - amountToWithdraw;
                  _controller.edit(widget.expense.id, widget.expense.name, amountToWithdraw, widget.expense.color, widget.expense.icon);
                  _controller.gotoPage(Builder(
                    builder: (context) {
                      return ExpensesPageView(title: "Expenses", balance: widget.balance, walletId: widget.walletId);
                    }
                  ), context);
                }
              },
              child: Container(
                height: 45.0,
                width: 164.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFC27C9C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Withdraw",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}
