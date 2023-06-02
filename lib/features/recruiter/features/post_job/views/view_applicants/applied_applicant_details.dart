import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobhunt_pro/apis/cloud_storage_api.dart';
import 'package:jobhunt_pro/features/applicant/features/job_detail/job_detail_screen.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/views/view_applicants/widget/view_cv.dart';
import 'package:jobhunt_pro/model/apply_job.dart';

import '../../../../../../common/custom_forms_kit.dart';
import '../../../../../../constants/app_svg.dart';
import '../../../../../../theme/colors.dart';

class AppliedApplicantDetails extends ConsumerStatefulWidget {
  final ApplyJob applyJob;
  const AppliedApplicantDetails({super.key, required this.applyJob});

  @override
  ConsumerState<AppliedApplicantDetails> createState() =>
      _AppliedApplicantDetailsState();
}

class _AppliedApplicantDetailsState
    extends ConsumerState<AppliedApplicantDetails> {
  bool pdfLoading = false;
  viewCv() async {
    final nav = Navigator.of(context);
    setState(() {
      pdfLoading = true;
    });
    await ref
        .watch(storageAPIProvider)
        .viewCv(fileId: widget.applyJob.cvId)
        .then((value) {
      setState(() {
        pdfLoading = false;
      });
      nav.push(MaterialPageRoute(
          builder: (context) => ViewCv(
                applicantName: '',
                filePath: value,
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    final details = widget.applyJob;
    final textStyle = Theme.of(context).textTheme.displayMedium;
    return Scaffold(
        appBar: AppBar(title: const Text('Applicant  Details')),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
              onPressed: viewCv,
              child: pdfLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'View Cv',
                      style: textStyle!
                          .copyWith(color: Colors.white, fontSize: 17),
                    )),
        ),
        body: SingleChildScrollView(
          child: ref
              .watch(applicantProfileDetailsProvider(details.applicantId))
              .when(
                  data: (applicant) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          child: ClipOval(
                              child: Image.network(applicant.profilePicture)),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(applicant.name,
                                style: textStyle!.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
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
                            Text(applicant.title,
                                style: textStyle.copyWith(fontSize: 15)),
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
                                  fontSize: 14,
                                  letterSpacing: 0.2,
                                  wordSpacing: 3)),
                        ),
                        const SizedBox(height: 20),
                        const CustomText(text: 'Skills', bold: true, size: 18),
                        BulletedListBuilder(
                            list: applicant.skills, padding: true),
                        const CustomText(
                            text: 'Experience', bold: true, size: 18),
                        BulletedListBuilder(
                            list: applicant.experience, padding: true),
                        const CustomText(
                            text: 'Cover Letter', bold: true, size: 18),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(details.coverLetter,
                              textAlign: TextAlign.start,
                              style: textStyle.copyWith(
                                fontSize: 14,
                                letterSpacing: 0.2,
                                wordSpacing: 3,
                              )),
                        ),
                        const SizedBox(height: 30),
                      ],
                    );
                  },
                  error: (error, stackTrace) => Center(
                        child: Text(error.toString()),
                      ),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      )),
        ));
  }
}
