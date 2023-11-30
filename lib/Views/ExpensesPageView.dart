import 'package:flutter/material.dart';
import 'package:itu_dev/Controllers/ExpensesPageController.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Views/NewExpensePageView.dart';
import 'package:itu_dev/Views/SpecificWalletView.dart';
import 'package:itu_dev/Views/expense_item_widget.dart';
import '../Models/ExpensesPageModel.dart';
import 'ExpenseDetailPageView.dart';

class ExpensesPageView extends StatefulWidget {
  const ExpensesPageView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ExpensesPageView> createState() => _ExpensesPageViewState();
}

class _ExpensesPageViewState extends State<ExpensesPageView> {
  final ExpensesPageController _controller = ExpensesPageController();

  void navigateToNewExpensePage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const NewExpensePageView(title: 'New Expense'),
    ));
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 120,
      backgroundColor: const Color(0xFF575093),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
            const SpecificWalletView(title: 'PayPal', balance: null),
          ));
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
      body: FutureBuilder<List<Expense>>(
        key: UniqueKey(),
        future: _controller.drawBubble(context, 255),
        builder: (context, AsyncSnapshot<List<Expense>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                  'Error loading expenses. Please try again later.',
                  style: TextStyle(color: Colors.white),),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(''),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final expense = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ExpenseDetailsPageView(expense: expense),
                      ));
                    },
                    child: ExpenseItemWidget(
                      color: expense.color,
                      name: expense.name,
                      amount: expense.amount,
                      icon: expense.icon.codePoint,
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(
              child: Text(''),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}
