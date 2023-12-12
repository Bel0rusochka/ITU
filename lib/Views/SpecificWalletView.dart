import 'package:flutter/material.dart';
import 'package:itu_dev/Models/BalancePageModel.dart';
import 'package:itu_dev/Views/BalancePageView.dart';
import 'package:itu_dev/Controllers/SpecificWalletPageController.dart';
import '../Models/ExpensesPageModel.dart';
import '../Models/IncomesPageModel.dart';
import 'BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Views/ExpensesPageView.dart';
import 'package:itu_dev/Controllers/BalancePageController.dart';
import 'IncomesPageView.dart';

class SpecificWalletView extends StatefulWidget {
  const SpecificWalletView({
    Key? key,
    required this.title,
    required this.balance,
    required this.walletId,
  }) : super(key: key);

  final String title;
  final int walletId;
  final Balance balance;

  @override
  State<SpecificWalletView> createState() => _SpecificWalletViewState();
}

class _SpecificWalletViewState extends State<SpecificWalletView> {
  final WalletPageController _controller = WalletPageController();
  final BalancePageController _controllerBalance = BalancePageController();
  final ExpensePageModel _expenseModel = ExpensePageModel();
  final IncomesPageModel _incomesModel = IncomesPageModel();

  @override
  void initState() {
    super.initState();
    loadWeekData();
  }

  Future<void> loadWeekData() async {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    // Load and calculate expenses for the current week
    List<Expense> expenses = await _expenseModel.loadDBData();
    num expenseSum = expenses
        .where((expense) =>
    expense.creationDate.isAfter(startOfWeek) &&
        expense.creationDate.isBefore(endOfWeek) &&
        expense.walletId == widget.walletId)
        .fold(0, (prev, expense) => prev + expense.amount);

    // Load and calculate incomes for the current week
    List<Income> incomes = await _incomesModel.loadDBData();
    num incomeSum = incomes
        .where((income) =>
    income.creationDate.isAfter(startOfWeek) &&
        income.creationDate.isBefore(endOfWeek) &&
        income.walletId == widget.walletId)
        .fold(0, (prev, income) => prev + income.amount);

    setState(() {
      expenseTotal = expenseSum;
      incomeTotal = incomeSum;
    });
  }

  num expenseTotal = 0;
  num incomeTotal = 0;

  @override
  Widget build(BuildContext context) {
    num balance = incomeTotal - expenseTotal;
    widget.balance.amount = balance.toString();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: const Color(0xFF575093),
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlexibleSpaceBar(
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  balance.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _controller.gotoPage(const BalancePageView(title: "My Balance"), context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            iconSize: 30,
            onPressed: () {
              _controllerBalance.dellBalance(widget.walletId);
              _controller.gotoPage(const BalancePageView(title: "My Balance"), context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              "This week",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      _controller.gotoPage(
                        ExpensesPageView(title: widget.title, balance: widget.balance, walletId: widget.walletId),
                        context,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFC27C9C),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Expense',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                expenseTotal.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      _controller.gotoPage(
                        IncomesPageView(title: widget.title, balance: widget.balance, walletId: widget.walletId),
                        context,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF62CB99),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Income',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                incomeTotal.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}
