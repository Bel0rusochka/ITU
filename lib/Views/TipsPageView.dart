import 'package:flutter/material.dart';
import 'package:itu_dev/Views/BottomNavigationBarWidgetView.dart';
import 'package:itu_dev/Controllers/TipsPageController.dart';

class TipsPageView extends StatefulWidget {
  const TipsPageView({super.key, required this.title});

  final String title;

  @override
  State<TipsPageView> createState() => _TipsPageViewState();
}

class _TipsPageViewState extends State<TipsPageView> {
  final TipsPageController _controller = TipsPageController();
  String chooseCategory = "All";
  Future<Column?> _drawBubble(chooseCategory) async {
    try {
      return await _controller.drawBubble(context, chooseCategory);
    } catch (e) {
      setState(() {});
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {

    print(21);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(widget.title, style: const TextStyle(fontSize: 28, color: Colors.white)),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              setState(() {
                chooseCategory = value;
              });
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'Useful',
                child: Text('Useful advice'),
              ),
              const PopupMenuItem<String>(
                value: 'Useless',
                child: Text('Useless advice'),
              ),
              const PopupMenuItem<String>(
                value: 'All',
                child: Text('All advice'),
              ),
              const PopupMenuItem<String>(
                value: 'None',
                child: Text('Without category advice'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: FutureBuilder<Column?>(
            future: _drawBubble(chooseCategory),
            builder: (context, AsyncSnapshot<Column?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(
                  child: Text('Error occurred or no data available'),
                );
              } else {
                return snapshot.data!;
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidgetView(),
    );
  }
}

