import 'package:flutter/material.dart';
import 'package:itu_dev/Views/DebtPageView.dart';
import 'package:itu_dev/Views/DebtEditDeletePage.dart';
import 'package:itu_dev/Controllers/DebtPageController.dart';

class DebtEditPageView extends StatefulWidget {
  const DebtEditPageView({super.key,required this.id, required this.name, required this.amount, required this.date});

  final id;
  final name;
  final amount;
  final date;

  @override
  State<DebtEditPageView> createState() => _DebtEditPageViewState();
}

class _DebtEditPageViewState extends State<DebtEditPageView>{
  final DebtPageController _controller = DebtPageController();


  @override
  Widget build(BuildContext context){
    String newName=widget.name;
    String newDate=widget.date;
    String newAmount=widget.amount;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: const Text("Edit", style: TextStyle(fontSize: 28, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed:  (){_controller.gotoPage(DebtEditDeletePage(id: widget.id, name: widget.name, amount: widget.amount, date: widget.date), context);}, // Вызов метода _goBack при нажатии кнопки "назад"
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 20)),
              onPressed: (){
                _controller.edit(widget.id, newName, newDate, newAmount);
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
                controller: TextEditingController(text: widget.name),
                onChanged: (text){newName=text;},
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
                controller: TextEditingController(text: widget.amount),
                onChanged: (text){newAmount = text;} ,
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
                controller: TextEditingController(text: widget.date),
                onChanged: (text){newDate = text;} ,
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