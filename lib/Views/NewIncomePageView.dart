import 'package:flutter/material.dart';
import 'package:itu_dev/Views/IncomesPageView.dart';
import 'package:itu_dev/Controllers/IncomesPageController.dart';

class NewIncomePageView extends StatefulWidget {
  const NewIncomePageView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NewIncomePageView> createState() => _NewIncomePageViewState();
}

class _NewIncomePageViewState extends State<NewIncomePageView> {
  final IncomesPageController _controller = IncomesPageController();

  String categoryName = "";
  String amount = "";
  int selectedColor = 0xFFDBB387;
  IconData selectedIcon = const IconData(0xf4d5, fontFamily: 'MaterialIcons');

  Future<void> _showErrorSnackBar(String message) async {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
                      .pop(const IconData(0xf05d6, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xf05d6, fontFamily: 'MaterialIcons'),
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
                      .pop(const IconData(0xf1dd, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xf1dd, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xf4d5, fontFamily: 'MaterialIcons'));
                },
                child: const Icon(IconData(0xf4d5, fontFamily: 'MaterialIcons'),
                    size: 36),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pop(const IconData(0xe59f, fontFamily: 'MaterialIcons', matchTextDirection: true));
                },
                child: const Icon(IconData(0xe59f, fontFamily: 'MaterialIcons', matchTextDirection: true),
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
        backgroundColor: const Color(0xFF575093),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 17.0),
              child: TextButton(
                child: const Text(
                  'Save',
                  style: TextStyle(color: Color(0xFF6f73d2), fontSize: 20),
                ),
                onPressed: () {
                  if (categoryName.isEmpty || amount.isEmpty) {
                    _showErrorSnackBar('Please fill in both name and amount.');
                  } else {
                    DateTime currentDate = DateTime.now();
                    _controller.save(
                        categoryName, int.parse(amount), selectedColor, selectedIcon,currentDate);
                    _controller.gotoPage(
                        const IncomesPageView(title: "Incomes"), context);
                  }
                },
              )
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
                  setState(() {
                    categoryName = text;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    amount = text;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text(
                    'Select Color: ',
                    style: TextStyle(color: Colors.white),
                  ),
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
                  const Text(
                    'Select Icon: ',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: chooseIcon,
                    child: Icon(selectedIcon, size: 30, color: Colors.white),
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
