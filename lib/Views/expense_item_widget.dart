import 'package:flutter/material.dart';

class ExpenseItemWidget extends StatelessWidget {
  final int color;
  final String name;
  final int amount;
  final IconData icon;

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
        width: 36.0,
        height: 36.0,
        decoration: BoxDecoration(
          color: Color(color),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24.0,
        ),
      ),
      title: Text(name),
      trailing: Text('\$${amount.toString()}'),
    );
  }
}
