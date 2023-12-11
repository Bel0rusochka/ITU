import 'package:flutter/material.dart';
import 'package:itu_dev/Models/BalancePageModel.dart';
import 'package:itu_dev/Views/EditIncomePageView.dart';
import '../Controllers/IncomesPageController.dart';
import '../Models/IncomesPageModel.dart';
import 'DepositIncomePageView.dart';
import 'IncomesPageView.dart';
import 'WithdrawIncomePageView.dart';

class IncomeDetailsPageView extends StatelessWidget {
  final Income income;
  final Balance balance;
  final int walletId;

  IncomeDetailsPageView({Key? key, required this.income, required this.walletId, required this.balance}) : super(key: key);

  final IncomesPageController _controller = IncomesPageController();

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
          'Income',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF575093),
        iconTheme: const IconThemeData(color: Colors.white),
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
                color: Color(income.color),
                child: SizedBox(
                  height: 80.0,
                  child: ListTile(
                    contentPadding:
                    const EdgeInsets.only(left: 25.0, right: 22.0, top: 15.0),
                    title: Text(
                      income.name,
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    trailing: Text(
                      income.amount.toString(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepositIncomePageView(income: income, balance: balance, walletId: walletId,)),
                      );
                    },
                    child: const Text('Deposit +'),
                  ),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WithdrawIncomePageView(income: income, balance: balance, walletId: walletId,)),
                      );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditIncomePageView(income: income, balance: balance, walletId: walletId,)),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                  ElevatedButton.icon(
                    style: deleteButtonStyle,
                    onPressed: () {
                      _controller.dellIncome(income.id);

                      _controller.gotoPage(IncomesPageView(title: "Incomes", balance: balance, walletId: walletId,), context);
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


