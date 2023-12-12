import 'package:flutter/material.dart';

class ExpenseItemWidget extends StatelessWidget {
  final int color;
  final String name;
  final num amount;
  final int icon;

  const ExpenseItemWidget({
    super.key,
    required this.color,
    required this.name,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 48.0,
        height: 48.0,
        decoration: BoxDecoration(
          color: Color(color),
          shape: BoxShape.circle,
        ),
        child: Icon(
          IconData(icon, fontFamily: 'MaterialIcons'),
          color: Colors.black,
          size: 24.0,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'MiriamLibre',
          fontSize: 20.0,
        ),
      ),
      trailing: Text(
        amount.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'MiriamLibre',
          fontSize: 20.0,
        ),
      ),
    );
  }
}
