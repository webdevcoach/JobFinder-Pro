import 'package:flutter/material.dart';
import 'package:jobhunt_pro/common/custom_forms_kit.dart';
import 'package:jobhunt_pro/routes/app_route.dart';

class ApplyJobDialog extends StatelessWidget {
  const ApplyJobDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                  text: 'Job Application Sent', bold: true, size: 25),
              const SizedBox(height: 3),
              const CustomText(text: 'Successfully', bold: true, size: 25),
              const SizedBox(height: 10),
              const CustomText(text: 'Best of luck!'),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, AppRoute.applicantsHomeView, (route) => false),
                  child: const CustomText(
                      text: 'Back to home', color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
