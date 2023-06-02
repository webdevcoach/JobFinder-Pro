import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobhunt_pro/common/custom_forms_kit.dart';
import 'package:jobhunt_pro/constants/app_svg.dart';
import 'package:jobhunt_pro/features/applicant/features/job_detail/job_detail_screen.dart';
import 'package:jobhunt_pro/model/applicant.dart';
import 'package:jobhunt_pro/theme/colors.dart';

class ApplicantDetails extends StatelessWidget {
  final Applicant applicant;
  const ApplicantDetails({super.key, required this.applicant});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayMedium;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              child: ClipOval(child: Image.network(applicant.profilePicture )),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(applicant.name,
                    style: textStyle!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(width: 7),
                Container(
                  height: 15,
                  width: 2,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 2),
                Container(
                  height: 15,
                  width: 2,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 7),
                Text(applicant.location,
                    style: textStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 5),
            CustomText(text: applicant.email, bold: true, size: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(applicant.title, style: textStyle.copyWith(fontSize: 15)),
                SvgPicture.asset(AppSvg.verifyBold,
                    color: AppColors.primaryColor),
              ],
            ),
            const SizedBox(height: 10),
            const CustomText(text: 'About', bold: true, size: 18),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(applicant.about,
                  textAlign: TextAlign.start,
                  style: textStyle.copyWith(
                      fontSize: 14, letterSpacing: 0.2, wordSpacing: 3)),
            ),
            const SizedBox(height: 20),
            const CustomText(text: 'Skills', bold: true, size: 18),
            BulletedListBuilder(list: applicant.skills, padding: true),
            const CustomText(text: 'Experience', bold: true, size: 18),
            BulletedListBuilder(list: applicant.experience, padding: true),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
