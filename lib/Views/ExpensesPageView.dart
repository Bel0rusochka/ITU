import 'package:flutter/material.dart';
import 'package:itu_dev/Controllers/ExpensesPageController.dart';
import 'package:itu_dev/Models/BalancePageModel.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Views/NewExpensePageView.dart';
import 'package:itu_dev/Views/SpecificWalletView.dart';
import 'package:itu_dev/Views/expense_item_widget.dart';
import '../Models/ExpensesPageModel.dart';
import 'ExpenseDetailPageView.dart';

class ExpensesPageView extends StatefulWidget {
  const ExpensesPageView({Key? key, required this.title, required this.walletId, required this.balance}) : super(key: key);

  final String title;
  final int walletId;
  final Balance balance;

  @override
  State<ExpensesPageView> createState() => _ExpensesPageViewState();
}

class _ExpensesPageViewState extends State<ExpensesPageView> {
  final ExpensesPageController _controller = ExpensesPageController();
  final ExpensePageModel _expenseModel = ExpensePageModel();
  List<Expense> _expenses = [];

  // Method to refresh the view when triggered
  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    List<Expense> allExpenses = await _expenseModel.loadDBData();
    setState(() {
      _expenses = allExpenses.where((expense) => expense.walletId == widget.walletId).toList();
    });
  }

  void navigateToNewExpensePage() {
    _controller.gotoPage(
      NewExpensePageView(title: 'New Expense', balance: widget.balance, walletId: widget.walletId),
      context,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 120,
      backgroundColor: const Color(0xFF575093),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          _controller.gotoPage(SpecificWalletView(title: widget.title, balance: widget.balance, walletId: widget.walletId),context);
        },
      ),
      title: const Text(
        "Expenses",
        style: TextStyle(
          fontSize: 32,
          color: Colors.white,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: navigateToNewExpensePage,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: _expenses.length,
          itemBuilder: (context, index) {
            final expense = _expenses[index];
            return InkWell(
              onTap: () {
                _controller.gotoPage(
                  ExpenseDetailsPageView(expense: expense, balance: widget.balance, walletId: widget.walletId),
                  context,
                );
              },
              child: ExpenseItemWidget(
                color: expense.color,
                name: expense.name,
                amount: expense.amount,
                icon: expense.icon.codePoint,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}
