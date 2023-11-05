import 'package:flutter/material.dart';
import 'package:itu_dev/Views/DebtAddPageView.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Controllers/DebtPageController.dart';

class DebtPageView extends StatefulWidget {
  const DebtPageView({super.key, required this.title});

  final String title;

  @override
  State<DebtPageView> createState() => _DebtPageViewState();
}

class _DebtPageViewState extends State<DebtPageView>{
  final DebtPageController _controller = DebtPageController();

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(widget.title, style: const TextStyle(fontSize: 28, color: Colors.white)),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              iconSize: 35,
              onPressed: (){
                _controller.gotoPage(const DebtAddPageView(title: "New Debts"), context);
              }
          )
        ],
      ),
      body: RefreshIndicator(

        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: FutureBuilder<Column?>(
              future: _controller.drawBubble(context, 255),
              builder: (context, AsyncSnapshot<Column?> snapshot) {
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
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}