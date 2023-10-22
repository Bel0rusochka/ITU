import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Tip{
  String title;
  String time;
  String text;


  Tip({required this.title, required this.time, required this.text});

  factory Tip.fromJson(Map<String, dynamic> json){
    return Tip(
      title: json['title'] as String,
      time: json['time'] as String,
      text: json['text'] as String,
    );
  }
}

class TipsPageModel{
  Future<List<Tip>> loadJsonData() async {
    String jsonData = await rootBundle.loadString('json/tips.json');
    final List<dynamic> data = json.decode(jsonData);
    final List<Tip> tips = data.map((dynamic e) => Tip.fromJson(e as Map<String, dynamic>)).toList();
    return tips;
  }

}