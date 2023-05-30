import 'package:flutter/material.dart';

class VerticalBar extends StatelessWidget {
  final String title;
  final String trailing;
  final void Function()? onTap;

  Widget child;
  VerticalBar({
    Key? key,
    required this.title,
    this.trailing = 'See all',
    this.child = const SizedBox(),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayLarge;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textBaseline: TextBaseline.ideographic,
      children: [
        Row(
          children: [
            Text(title, style: textStyle!.copyWith(fontSize: 20)),
            const SizedBox(
              width: 6,
            ),
            child,
          ],
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            trailing,
            style:
                textStyle.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        )
      ],
    );
  }
}
