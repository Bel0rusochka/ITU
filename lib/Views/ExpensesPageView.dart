import 'package:flutter/material.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Controllers/ExpensesPageController.dart';
import 'package:itu_dev/Views/SpecificWalletView.dart';
import 'package:itu_dev/Views/NewExpensePageView.dart';
import 'package:itu_dev/Views/expense_item_widget.dart';

class ExpensesPageView extends StatefulWidget {
  const ExpensesPageView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ExpensesPageView> createState() => _ExpensesPageViewState();
}

class _ExpensesPageViewState extends State<ExpensesPageView> {
  final ExpensesPageController _controller = ExpensesPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: const Color(0xFF575093),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NewExpensePageView(title: 'New Expense'),
              ));
            },
          ),
        ],
        flexibleSpace: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlexibleSpaceBar(
              title: Text(
                "Expenses",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SpecificWalletView(title: 'PayPal', balance: null),
            ));
          },
        ),
      ),
      body: FutureBuilder<List<ExpenseItemWidget>>(
        future: _controller.drawBubble(context, 255),
        builder: (context, AsyncSnapshot<List<ExpenseItemWidget>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final expenseItem = snapshot.data![index];
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.account_balance_wallet_rounded),
                    ),
                    title: Text(expenseItem.name),
                    trailing: Text(expenseItem.amount.toString()),
                  );
                },
              );
            }
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),

      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}
