import 'package:flutter/material.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Controllers/TipsPageController.dart';

class TipsPageView extends StatefulWidget {
  const TipsPageView({super.key, required this.title});

  final String title;

  @override
  State<TipsPageView> createState() => _TipsPageViewState();
}

class _TipsPageViewState extends State<TipsPageView>{

  final TipsPageController _controller = TipsPageController();
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue.shade50,
        title: Text(widget.title, style: const TextStyle(fontSize: 28)),
      ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: FutureBuilder<Column?>(
              future: _controller.drawBubble(context),
              builder: (context, AsyncSnapshot<Column?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
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
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}
