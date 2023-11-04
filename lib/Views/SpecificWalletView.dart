import 'package:flutter/material.dart';
import 'package:itu_dev/Views/BalancePageView.dart';
import 'package:itu_dev/Controllers/SpecificWalletPageController.dart';
import 'BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Views/ExpensesPageView.dart';

class SpecificWalletView extends StatefulWidget {
  const SpecificWalletView({Key? key, required this.title, required this.balance, this.expense, this.income}) : super(key: key);

  final String title;
  final dynamic balance;
  final dynamic expense;
  final dynamic income;

  @override
  State<SpecificWalletView> createState() => _SpecificWalletViewState();
}

class _SpecificWalletViewState extends State<SpecificWalletView> {
  final WalletPageController _controller = WalletPageController();

  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xFF575093);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: const Color(0xFF575093),
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const FlexibleSpaceBar(
              title: Text(
                "PayPal",
                style: TextStyle(
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
                  widget.balance.toString(),
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
                      _controller.gotoPage(const ExpensesPageView(title: "Expenses"), context);
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
                                widget.expense.toString(),
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
                              widget.income.toString(),
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
