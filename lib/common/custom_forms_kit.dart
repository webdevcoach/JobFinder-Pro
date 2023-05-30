import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  bool bold;
  Color? color;
  double? size;
  CustomText({
    Key? key,
    required this.text,
    this.bold = false,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme.displayMedium;

    return Text(text,
        style: txtStyle!.copyWith(
          fontSize: size,
          color: color,
          fontWeight: bold ? FontWeight.bold : null,
        ));
  }
}

class CustomTextBold extends StatelessWidget {
  final String text;
  const CustomTextBold({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme.displayMedium;

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(text,
          style: txtStyle!.copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool enableMaxlines;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.enableMaxlines = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: enableMaxlines ? 5 : 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.greyColor,
          ),
        ),
        //hintText: 'hintText',
        hintStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
