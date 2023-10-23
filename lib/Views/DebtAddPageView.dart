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
        backgroundColor: Colors.lightBlue.shade50,
        title: Text(widget.title, style: const TextStyle(fontSize: 28)),
        actions: <Widget>[
          TextButton(
              child: const Text('Save', style: TextStyle(color: Colors.lightBlue, fontSize: 20)),
              onPressed: (){
                _controller.save(name, date, amount);
                _controller.returnDebtPage(const DebtPageView(title: "My Debt"), context);
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
                onChanged: (text){name=text;},
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text){amount = text;} ,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text){date = text;} ,
                decoration: const InputDecoration(
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