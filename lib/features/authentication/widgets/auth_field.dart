import 'package:flutter/material.dart';
import 'package:jobhunt_pro/theme/colors.dart';

class CustomAuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool showObscureText;
  final bool isPasswordField;

  const CustomAuthField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.showObscureText = false,
      this.isPasswordField = false});

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme.displayMedium;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        obscureText: showObscureText,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          suffixIcon: isPasswordField
              ? Icon(showObscureText
                  ? Icons.remove_red_eye
                  : Icons.panorama_fish_eye)
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColors.greyColor,
            ),
          ),
          // contentPadding: const EdgeInsets.all(22),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
