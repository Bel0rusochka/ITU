import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itu_dev/Models/BalancePageModel.dart';
import 'package:itu_dev/Models/IncomesPageModel.dart';
import '../Controllers/IncomesPageController.dart';
import 'BottomNavigationBarWidgetView.dart';
import 'IncomesPageView.dart';

class WithdrawIncomePageView extends StatefulWidget {
  final Income income;
  final int walletId;
  final Balance balance;

  const WithdrawIncomePageView({Key? key, required this.income,required this.walletId, required this.balance}) : super(key: key);

  @override
  State<WithdrawIncomePageView> createState() => _WithdrawPageViewState();
}

class _WithdrawPageViewState extends State<WithdrawIncomePageView> {
  final IncomesPageController _controller = IncomesPageController();
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
            _controller.gotoPage(IncomesPageView(title: "Incomes", balance: widget.balance, walletId: widget.walletId,), context);
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
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            GestureDetector(
              onTap: () async {
                if (newAmount.isNotEmpty) {
                  num amountToWithdraw = num.tryParse(newAmount) ?? 0;
                  amountToWithdraw = widget.income.amount - amountToWithdraw;
                  _controller.edit(widget.income.id, widget.income.name, amountToWithdraw, widget.income.color, widget.income.icon);
                  _controller.gotoPage(Builder(
                      builder: (context) {
                        return IncomesPageView(title: "Incomes", balance: widget.balance, walletId: widget.walletId,);
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
