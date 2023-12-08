import 'package:flutter/material.dart';

import '../Controllers/BalancePageController.dart';
import 'BalancePageView.dart';

class BalanceAddPageView extends StatefulWidget {
  const BalanceAddPageView({super.key, required this.title});

  final String title;

  @override
  State<BalanceAddPageView> createState() => _BalanceAddPageViewState();
}

class _BalanceAddPageViewState extends State<BalanceAddPageView>{
  final BalancePageController _controller = BalancePageController();


  @override
  Widget build(BuildContext context){
    String name="";
    String amount="";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue.shade50,
        title: Text(widget.title, style: const TextStyle(fontSize: 28)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:  (){_controller.gotoPage(const BalancePageView(title: "My Balance"), context);},
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('Save', style: TextStyle(color: Colors.lightBlue, fontSize: 20)),
              onPressed: (){
                _controller.saveBalance(name, amount);
                _controller.gotoPage(const BalancePageView(title: "My Balance"), context);
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

          ],
        ),
      ),
    );
  }
}