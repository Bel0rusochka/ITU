import 'package:flutter/material.dart';

class ExpenseItemWidget extends StatelessWidget {
  final Color color;
  final String name;
  final int amount;
  final IconData icon;

  const ExpenseItemWidget({super.key,
    required this.color,
    required this.name,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color, size: 36.0),
      title: Text(name),
      trailing: Text('\$${amount.toString}'),
    );
  }
}
