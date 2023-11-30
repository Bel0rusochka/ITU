import 'package:flutter/material.dart';
import 'package:itu_dev/Controllers/IncomesPageController.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Views/NewIncomePageView.dart';
import 'package:itu_dev/Views/SpecificWalletView.dart';
import 'package:itu_dev/Views/income_item_widget.dart';
import '../Models/IncomesPageModel.dart';
import 'IncomeDetailPageView.dart';

class IncomesPageView extends StatefulWidget {
  const IncomesPageView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<IncomesPageView> createState() => _IncomesPageViewState();
}

class _IncomesPageViewState extends State<IncomesPageView> {
  final IncomesPageController _controller = IncomesPageController();

  void navigateToNewIncomePage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const NewIncomePageView(title: 'New Income'),
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
      body: FutureBuilder<List<Income>>(
        key: UniqueKey(),
        future: _controller.drawBubble(context, 255),
        builder: (context, AsyncSnapshot<List<Income>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error loading Incomes. Please try again later.',
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
                  final income = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => IncomeDetailsPageView(income: income),
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
