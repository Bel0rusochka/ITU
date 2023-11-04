import 'package:flutter/material.dart';

class ExpenseItemWidget extends StatelessWidget {
  final Color categoryColor;
  final String categoryName;
  final int categoryAmount;
  final IconData categoryIcon;

  const ExpenseItemWidget({super.key,
    required this.categoryColor,
    required this.categoryName,
    required this.categoryAmount,
    required this.categoryIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(categoryIcon, color: categoryColor, size: 36.0),
      title: Text(categoryName),
      trailing: Text('\$${categoryAmount.toString}'),
    );
  }
}
