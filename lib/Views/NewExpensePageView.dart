import 'package:flutter/material.dart';
import 'package:itu_dev/Views/ExpensesPageView.dart';
import 'package:itu_dev/Controllers/ExpensesPageController.dart';

class NewExpensePageView extends StatefulWidget {
  const NewExpensePageView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NewExpensePageView> createState() => _NewExpensePageViewState();
}

class _NewExpensePageViewState extends State<NewExpensePageView> {
  final ExpensesPageController _controller = ExpensesPageController();

  String categoryName = "";
  String amount = "";
  int selectedColor = 0xFFDBB387;
  IconData selectedIcon = const IconData(0xe59c, fontFamily: 'MaterialIcons');

  Future<void> chooseColor() async {
    int? pickedColor = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Color'),
          content: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(0xFFDBB387);
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFDBB387),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(0xFF44C7BB);
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF44C7BB),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(0xFF6F73D2);
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF6F73D2),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedColor != null) {
      setState(() {
        selectedColor = pickedColor;
      });
    }
  }

  Future<void> chooseIcon() async {
    IconData? pickedIcon = await showDialog<IconData>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Icon'),
          content: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe59c, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xe59c, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe1d5, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xe1d5, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe318, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xe318, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe396, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xe396, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe05d, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xe05d, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe054, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xe054, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe06d, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xe06d, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe0b2, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xe0b2, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe146, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xe146, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe15d, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xe15d, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe237, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xe237, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe5e8, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xe5e8, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
            ],
          ),
        );
      },
    );

    if (pickedIcon != null) {
      setState(() {
        selectedIcon = pickedIcon;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue.shade50,
        title: Text(widget.title, style: const TextStyle(fontSize: 28)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _controller.gotoPage(
                const ExpensesPageView(title: "New Expense"), context);
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Save',
                style: TextStyle(color: Colors.lightBlue, fontSize: 20)),
            onPressed: () {
              _controller.save(
                  categoryName, int.parse(amount), selectedColor, selectedIcon);
              _controller.gotoPage(
                  const ExpensesPageView(title: "Expenses"), context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text) {
                  categoryName = text;
                },
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text) {
                  amount = text;
                },
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text('Select Color: '),
                  GestureDetector(
                    onTap: chooseColor,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(selectedColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text('Select Icon: '),
                  GestureDetector(
                    onTap: chooseIcon,
                    child: Icon(selectedIcon, size: 36),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
