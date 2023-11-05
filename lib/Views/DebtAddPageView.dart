import 'package:flutter/material.dart';
import 'package:itu_dev/Views/DebtPageView.dart';
import 'package:itu_dev/Controllers/DebtPageController.dart';

class DebtAddPageView extends StatefulWidget {
  const DebtAddPageView({super.key, required this.title});

  final String title;

  @override
  State<DebtAddPageView> createState() => _DebtAddPageViewState();
}

class _DebtAddPageViewState extends State<DebtAddPageView>{
  final DebtPageController _controller = DebtPageController();


  @override
  Widget build(BuildContext context){
    String name="";
    String amount="";
    String date="";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(widget.title, style: const TextStyle(fontSize: 28, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed:  (){_controller.gotoPage(const DebtPageView(title: "My Debt"), context);}, // Вызов метода _goBack при нажатии кнопки "назад"
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 20)),
              onPressed: (){
                _controller.save(name, date, amount);
                _controller.gotoPage(const DebtPageView(title: "My Debt"), context);
              }
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (text){name=text;},
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(100, 255, 255, 255),
                  ),
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (text){amount = text;} ,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(100, 255, 255, 255),
                  ),
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (text){date = text;} ,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(100, 255, 255, 255),
                  ),
                  labelText: 'Date for pay off',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}