import 'package:flutter/material.dart';
import 'package:itu_dev/Controllers/TipsPageController.dart';
import 'package:itu_dev/Views/TipsPageView.dart';

class TipsTextPageView extends StatefulWidget {
  const TipsTextPageView({
    super.key,
    required this.title,
    required this.time,
    required this.text,
    required this.category,
  });

  final title;
  final time;
  final text;
  final category;

  @override
  State<TipsTextPageView> createState() => _TipsTextPageViewState();
}

class _TipsTextPageViewState extends State<TipsTextPageView> {
  String selectedCategory = "";
  TipsPageController _controller = TipsPageController();

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: const Text("My Financial advice", style: TextStyle(fontSize: 28, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed:  (){_controller.gotoPage(const TipsPageView(title: "My Financial advices"), context);},
        ),

      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              widget.text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 90),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCategoryButton('Useful', 'Useful'),
                buildCategoryButton('None', 'No Category'),
                buildCategoryButton('Useless', 'Useless'),
              ],
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryButton(String category, String label) {
    final isSelected = selectedCategory == category;

    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = category;
          _controller.editCategory(widget.title, widget.time, widget.text, category);
        });
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}