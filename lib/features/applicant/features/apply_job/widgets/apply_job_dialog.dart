import 'package:flutter/material.dart';
import 'package:jobhunt_pro/common/custom_forms_kit.dart';
import 'package:jobhunt_pro/features/applicant/features/home/views/page_navigator.dart';
import 'package:jobhunt_pro/routes/app_route.dart';

class ApplyJobDialog extends StatelessWidget {
  const ApplyJobDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(text: 'Job Application Sent', bold: true, size: 25),
          const SizedBox(height: 3),
          CustomText(text: 'Successfully', bold: true, size: 25),
          const SizedBox(height: 10),
          CustomText(text: 'Best of luck!'),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => AppRoute.toPage(const ApplicantPageNavigator()),
              child: CustomText(text: 'Back to home', color: Colors.white))
        ],
      ),
    );
  }
}
