import 'package:flutter/material.dart';
import 'package:jobhunt_pro/theme/colors.dart';

class CustomAuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPasswordField;

  const CustomAuthField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPasswordField = false,
  });

  @override
  State<CustomAuthField> createState() => _CustomAuthFieldState();
}

class _CustomAuthFieldState extends State<CustomAuthField> {
  bool showObscureText = true;

  void showHidePassword() {
    setState(() {
      showObscureText = !showObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme.displayMedium;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        obscureText: showObscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.isPasswordField ? Icons.lock : Icons.mail),
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            onPressed: showHidePassword,
            icon: widget.isPasswordField
                ? Icon(showObscureText
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded)
                : const SizedBox(),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.6),
            ),
          ),
          // contentPadding: const EdgeInsets.all(22),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
