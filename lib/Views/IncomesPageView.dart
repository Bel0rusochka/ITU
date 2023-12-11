import 'package:flutter/material.dart';
import 'package:itu_dev/Controllers/IncomesPageController.dart';
import 'package:itu_dev/Models/BalancePageModel.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Views/NewIncomePageView.dart';
import 'package:itu_dev/Views/SpecificWalletView.dart';
import 'package:itu_dev/Views/income_item_widget.dart';
import '../Models/IncomesPageModel.dart';
import 'IncomeDetailPageView.dart';

class IncomesPageView extends StatefulWidget {
  const IncomesPageView({Key? key, required this.title, required this.walletId, required this.balance}) : super(key: key);

  final String title;
  final int walletId;
  final Balance balance;

  @override
  State<IncomesPageView> createState() => _IncomesPageViewState();
}

class _IncomesPageViewState extends State<IncomesPageView> {
  final IncomesPageController _controller = IncomesPageController();
  final IncomesPageModel _incomeModel = IncomesPageModel();
  List<Income> _incomes = [];

  @override
  void initState() {
    super.initState();
    loadIncomes();
  }

  // Method to refresh the view when triggered
  Future<void> _refresh() async {
    setState(() {});
  }

  Future<void> loadIncomes() async {
    List<Income> allIncomes = await _incomeModel.loadDBData();
    setState(() {
      _incomes = allIncomes.where((income) => income.walletId == widget.walletId).toList();
    });
  }

  void navigateToNewIncomePage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewIncomePageView(title: 'New Income',balance: widget.balance, walletId: widget.walletId),
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
                SpecificWalletView(title: widget.title, balance: widget.balance, walletId: widget.walletId),
          ));
        },
      ),
      title: const Text(
        "Incomes",
        style: TextStyle(
          fontSize: 32,
          color: Colors.white,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: navigateToNewIncomePage,
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
        itemCount: _incomes.length,
        itemBuilder: (context, index) {
          final income = _incomes[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IncomeDetailsPageView(income: income, balance: widget.balance, walletId: widget.walletId),
              ));
            },
            child: IncomeItemWidget(
              color: income.color,
              name: income.name,
              amount: income.amount,
              icon: income.icon.codePoint,
            ),
          );
        },
      ),
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}
