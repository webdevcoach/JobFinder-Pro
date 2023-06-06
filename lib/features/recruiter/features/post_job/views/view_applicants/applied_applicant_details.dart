import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/apis/cloud_storage_api.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/views/view_applicants/widget/applicant_details_section.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/views/view_applicants/widget/decorated_box_container.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/views/view_applicants/widget/view_cv.dart';
import 'package:jobhunt_pro/model/apply_job.dart';
import 'package:jobhunt_pro/theme/colors.dart';

import '../../../../../../common/custom_forms_kit.dart';
import '../../../../../../constants/app_svg.dart';
import '../../../../../../core/enums/application_status.dart';
import '../../controller/post_job_controller.dart';

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
      appBar: AppBar(
          // title: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     /// will change this modalbottomsheet
          //     const Chip(
          //         label: CustomText(text: 'Reject', size: 20),
          //         backgroundColor: Colors.red),
          //     InkWell(
          // onTap: () => ref
          //     .watch(postJobControllerProvider.notifier)
          //     .acceptOrReject(
          //         applyJob: widget.applyJob
          //             .copyWith(status: ApplicationStatus.accepted)),
          //       child: const Chip(
          //         label: CustomText(text: 'Accept', size: 20),
          //         backgroundColor: Color.fromARGB(255, 20, 220, 27),
          //       ),
          //     )
          //   ],
          // ),

          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: const Icon(Icons.document_scanner_sharp))
          // ],
          ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(12),
      //   child: ElevatedButton(
      //       onPressed: viewCv,
      //       child: pdfLoading
      //           ? const CircularProgressIndicator(
      //               color: Colors.white,
      //             )
      //           : Text(
      //               'View CV',
      //               style: textStyle!
      //                   .copyWith(color: Colors.white, fontSize: 17),
      //             )),
      // ),

      body: SingleChildScrollView(
        child: ref
            .watch(applicantProfileDetailsProvider(details.applicantId))
            .when(
                data: (applicant) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        ApplicantDetailsSection(applicant: applicant),
                        InkWell(
                          onTap: viewCv,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: AppColors.primaryColor,
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 2)
                                ],
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    AppColors.primaryColor.withOpacity(0.05)),
                            child: Row(children: [
                              SvgPicture.asset(AppSvg.filePdfBold,
                                  height: 30,
                                  width: 30,
                                  color: AppColors.primaryColor),
                              const SizedBox(width: 10),
                              CustomText(
                                  text: pdfLoading ? 'loading' : 'View CV'),
                              const Spacer(),
                              Icon(IconlyLight.arrow_right_2,
                                  color: Colors.blue.shade800)
                            ]),
                          ),
                        ),
                        const SizedBox(height: 12),
                        DecoratedBoxContainer(
                          children: [
                            const CustomText(
                                text: 'Cover Letter', bold: true, size: 18),
                            const SizedBox(height: 5),
                            Text(details.coverLetter,
                                textAlign: TextAlign.start,
                                style: textStyle!.copyWith(
                                  fontSize: 14,
                                  letterSpacing: 0.2,
                                  wordSpacing: 3,
                                )),
                          ],
                        ),

                        // const SizedBox(height: 30),
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) => Center(
                      child: Text(error.toString()),
                    ),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    )),
      ),
      bottomNavigationBar: Row(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      color: AppColors.primaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(20),
              onPressed: () {
                ref.watch(postJobControllerProvider.notifier).acceptOrReject(
                    applyJob: widget.applyJob
                        .copyWith(status: ApplicationStatus.rejected));
              },
              child: const CustomText(
                  text: 'Reject', color: AppColors.primaryColor)),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
              color: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(20),
              onPressed: () => ref
                  .watch(postJobControllerProvider.notifier)
                  .acceptOrReject(
                      applyJob: widget.applyJob
                          .copyWith(status: ApplicationStatus.accepted)),
              child: const CustomText(text: 'Accept', color: Colors.white)),
        ))
      ]),
    );
  }
}
