import 'package:flutter/material.dart';

class MealIteTrait extends StatelessWidget {
  const MealIteTrait({super.key, required this.icon, required this.label});
final IconData icon;
final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: Colors.white),
        const SizedBox(width: 4),
        Text(label,style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.white
        ),),
      ],);
  }
}
                    