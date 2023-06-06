import 'package:flutter/material.dart';

import '../../../../../../../theme/colors.dart';

class DecoratedBoxContainer extends StatelessWidget {
  final List<Widget> children;
  const DecoratedBoxContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
              color: AppColors.secondaryColor,
              blurStyle: BlurStyle.outer,
              blurRadius: 1.2)
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }
}
