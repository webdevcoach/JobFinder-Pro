import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  final String title;
  final Color titleColor;
  final double fontSize;
  final BorderRadius? borderRadius;
  final bool bold;
  const InfoChip(
      {Key? key,
      required this.title,
      required this.titleColor,
      this.borderRadius,
      this.bold = true,
      this.fontSize = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Chip(
    //   label: Text(
    //     title,
    //     style: Theme.of(context).textTheme.displayLarge!.copyWith(
    //         color: titleColor, fontSize: 16, fontWeight: FontWeight.w500),
    //   ),
    //   backgroundColor: titleColor.withOpacity(0.15),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    // );
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: titleColor.withOpacity(0.15),
            borderRadius: borderRadius ?? BorderRadius.circular(6)),
        child: Text(
          " $title ",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: titleColor,
              fontSize: fontSize,
              fontWeight: bold ? FontWeight.w500 : FontWeight.normal),
        ));
  }
}
