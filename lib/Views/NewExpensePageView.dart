import 'package:flutter/material.dart';
import 'package:itu_dev/Views/ExpensesPageView.dart';
import 'package:itu_dev/Controllers/ExpensesPageController.dart';

class NewExpensePageView extends StatefulWidget {
  const NewExpensePageView({super.key, required this.title});

  final String title;

  @override
  State<NewExpensePageView> createState() => _NewExpensePageViewState();
}

class _NewExpensePageViewState extends State<NewExpensePageView> {
  final ExpensesPageController _controller = ExpensesPageController();

  String categoryName = "";
  String amount = "";
  Color selectedColor = const Color(0xFFDBB387);
  IconData selectedIcon = Icons.category;

  Future<void> chooseColor() async {
    Color? pickedColor = await showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Color'),
          content: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(const Color(0xFFDBB387));
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
                  Navigator.of(context).pop(const Color(0xFF44C7BB));
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
                  Navigator.of(context).pop(const Color(0xFF6F73D2));
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
                  Navigator.of(context).pop(Icons.category);
                },
                child: const Icon(Icons.category, size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(Icons.shopping_cart);
                },
                child: const Icon(Icons.shopping_cart, size: 36),
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
            _controller.gotoPage(const ExpensesPageView(title: "New Expense"), context);
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Save', style: TextStyle(color: Colors.lightBlue, fontSize: 20)),
            onPressed: () {
              _controller.save(categoryName, int.parse(amount), selectedColor, selectedIcon);
              _controller.gotoPage(const ExpensesPageView(title: "Expenses"), context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Ввод имени категории
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
            // Ввод суммы траты
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
            // Выбор цвета
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
                        color: selectedColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Выбор иконки
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
