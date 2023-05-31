// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:jobhunt_pro/common/custom_forms_kit.dart';
import 'package:jobhunt_pro/features/applicant/features/apply_job/controller/apply_job_conntroller.dart';
import 'package:jobhunt_pro/model/applicant.dart';
import 'package:jobhunt_pro/model/post_job.dart';
import 'package:jobhunt_pro/theme/colors.dart';

import '../../../../../core/resuables/pick_image.dart';

class ApplyJobView extends ConsumerStatefulWidget {
  final PostJob jobDetails;
  final Applicant applicant;
  const ApplyJobView({
    super.key,
    required this.jobDetails,
    required this.applicant,
  });

  @override
  ConsumerState<ApplyJobView> createState() => _ApplyJobViewState();
}

class _ApplyJobViewState extends ConsumerState<ApplyJobView> {
  final coverLetterController = TextEditingController();
  late File cv;
  bool isUploaded = false;

  @override
  Widget build(BuildContext context) {
    void applyJob() {
      ref.watch(applyJobControllerProvider.notifier).applyJob(
            context: context,
            cv: cv,
            coverLetter: coverLetterController.text,
            jobId: widget.jobDetails.jobId,
            ref: ref,
            applicant: widget.applicant,
            selectedJob: widget.jobDetails,
          );
    }

    Future<void> pickCV() async {
      cv = await PickFile.pickPdf();
      setState(() {
        isUploaded = true;
      });
    }

    final applyJobState = ref.watch(applyJobControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: applyJobState == ApplyJobState.loading
              ? const CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextBold(text: 'Cover Letter'),
                    CustomTextField(
                        controller: coverLetterController,
                        enableMaxlines: true),
                    const CustomTextBold(text: 'Upload CV'),
                    GestureDetector(
                      onTap: pickCV,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(20),
                        dashPattern: const [10, 10],
                        color: Colors.grey.shade400.withOpacity(0.8),
                        strokeWidth: 2,
                        child: Container(
                          // padding: const EdgeInsets.all(20),
                          // margin: const EdgeInsets.all(20),
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isUploaded
                                ? Colors.green.withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/recruiter_icons/document-upload.svg',
                                  color:
                                      AppColors.primaryColor.withOpacity(0.9),
                                  height: 30,
                                ),
                                const SizedBox(height: 10),
                                CustomText(
                                    text:
                                        isUploaded ? 'Uploaded' : 'Browse file')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () async {
                          applyJob();
                        },
                        child: CustomText(text: 'Submit', color: Colors.white))
                  ],
                ),
        ),
      ),
    );
  }
}
