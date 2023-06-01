import 'package:flutter/material.dart';
import 'package:jobhunt_pro/theme/colors.dart';
import 'package:email_validator/email_validator.dart';

class CustomAuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPasswordField;

  const CustomAuthField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPasswordField = false,
  }) : super(key: key);

  @override
  State<CustomAuthField> createState() => _CustomAuthFieldState();
}

class _CustomAuthFieldState extends State<CustomAuthField> {
  bool showObscureText = true;
  String? _errorMessage;

  void showHidePassword() {
    setState(() {
      showObscureText = !showObscureText;
    });
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }

    if (widget.isPasswordField) {
      if (value.length < 8) {
        return 'Password must be at least 8 characters';
      }
    } else {
      if (!EmailValidator.validate(value)) {
        return 'Please enter a valid email';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        obscureText: widget.isPasswordField ? showObscureText : false,
        controller: widget.controller,
        validator: _validator,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.isPasswordField ? Icons.lock : Icons.mail,
            color: AppColors.secondaryColor,
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  splashColor: Colors.transparent,
                  onPressed: showHidePassword,
                  icon: Icon(
                      showObscureText
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: AppColors.secondaryColor))
              : const SizedBox(),
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
          errorText: _errorMessage,
        ),
      ),
    );
  }
}
