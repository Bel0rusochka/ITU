import 'package:flutter/material.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import '../Controllers/BalancePageController.dart';
import 'BalanceAddPageView.dart';
import 'BottomNavigationBarWidgetView.dart';
class BalancePageView extends StatefulWidget {
  const BalancePageView({super.key, required this.title});

  final String title;

  @override
  State<BalancePageView> createState() => _BalancePageViewState();
}


class _BalancePageViewState extends State<BalancePageView> {
  final BalancePageController _controller = BalancePageController();
  Color color = const Color.fromARGB(255, 128, 197, 215);
  var wightBubble = 372.0;
  var heightBubble = 70.0;
  late num totalAmount; // Declare totalAmount as a late variable

  @override
  void initState() {
    super.initState();
    // Load the totalAmount when the widget is initialized
    _controller.calculateTotalAmount().then((value) {
      setState(() {
        totalAmount = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue.shade50,
        title: Text(widget.title, style: const TextStyle(fontSize: 28)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 35,
            onPressed: () {
              _controller.gotoPage(const BalanceAddPageView(title: "New Balance"), context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: heightBubble,
                width: wightBubble,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'My Total',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        '${totalAmount ?? 0}\$',
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder<Widget>(
                future: _controller.drawBubbleBalance(context, 255),
                builder: (context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return snapshot.data!;
                  } else {
                    return const Center(
                      child: Text('No data available'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}