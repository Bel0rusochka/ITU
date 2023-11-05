import 'package:flutter/material.dart';

class TipsTextPageView extends StatefulWidget{
  const TipsTextPageView({super.key, required this.title, required this.text, required this.textTitle});

  final textTitle;
  final text;
  final title;

  @override
  State<TipsTextPageView> createState() => _TipsTextPageViewState();
}

class _TipsTextPageViewState extends State<TipsTextPageView>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(widget.title, style: const TextStyle(fontSize: 28, color: Colors.white)),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.textTitle,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(widget.text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}