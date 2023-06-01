// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/core/extensions/to_msp.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';
import 'package:jobhunt_pro/model/post_job.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:jobhunt_pro/common/route_transition.dart';
import 'package:jobhunt_pro/theme/colors.dart';

import '../../../../common/custom_appbar.dart';
import '../../../../common/custom_forms_kit.dart';
import '../../../../common/info_chip.dart';
import '../../../../core/resuables/date_format.dart';
import '../apply_job/views/apply_job_view.dart';

class JobDetailScreen extends ConsumerWidget {
  final PostJob jobsData;
  const JobDetailScreen({
    Key? key,
    required this.jobsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final jobsData = ref.watch(postedJobDetailsProvider(jobId)).value;

    // final companyDetails =
    //     ref.watch(recruiterProfileDetailsProvider(jobsData!.companyId)).value;
    // //     .value;
    // if (jobsData == null && jobsData==null) {
    //   return const SizedBox();
    // }

    // (companyDetails == null)
    //     ? const Center(child: CircularProgressIndicator())
    //     :

    final textStyle = Theme.of(context).textTheme.displayLarge!;

    return Scaffold(
      appBar: CustomAppBar(
        onPrefixTap: () => Navigator.pop(context),
        prefixIcon: IconlyLight.arrow_left_2,
        title: 'Details',
        // suffixIcon:
        //     selectedJob.isSaved ? IconlyBold.bookmark : IconlyLight.bookmark,
      ),
      body: SingleChildScrollView(
          child: ref
              .watch(recruiterProfileDetailsProvider(jobsData.companyId))
              .when(
                data: (recruiter) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 1.5)
                                ]),
                            child: Column(children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurStyle: BlurStyle.outer,
                                          blurRadius: 1.5)
                                    ]),
                                child: Image.network(
                                  recruiter.logoUrl,
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              const SizedBox(height: 15),
                              CustomText(
                                text: jobsData.jobTitle,
                                bold: true,
                                size: 18,
                              ),
                              const SizedBox(height: 10),
                              CustomText(
                                  text: recruiter.companyName,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                  bold: true),
                              const SizedBox(height: 10),
                              Divider(color: Colors.grey.shade400),
                              const SizedBox(height: 10),
                              CustomText(text: jobsData.location),
                              const SizedBox(height: 10),
                              CustomText(
                                text: jobsData.salary,
                                color: AppColors.primaryColor,
                                bold: true,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InfoChip(
                                      title: jobsData.jobType,
                                      titleColor: Colors.blueGrey),
                                  const SizedBox(width: 10),
                                  InfoChip(
                                      title: jobsData.workingMode,
                                      titleColor: Colors.blueGrey)
                                ],
                              ),
                              const SizedBox(height: 10),
                              CustomText(
                                text:
                                    'Posted ${timeago.format(jobsData.time)}, ends in ${formatDate(jobsData.deadline)}',
                                size: 13,
                              ),
                              const SizedBox(height: 10),
                            ]),
                          ),

                          const SizedBox(height: 20),
                          const CustomText(
                              text: 'Description', bold: true, size: 18),
                          const SizedBox(height: 10),

                          CustomText(text: jobsData.description),

                          const SizedBox(height: 20),
                          const CustomText(
                              text: 'Requirements', bold: true, size: 18),
                          const SizedBox(height: 10),

                          BulletedListBuilder(
                              list: jobsData.requirement, padding: true),
                          const CustomText(
                              text: 'Responsibilities', bold: true, size: 18),
                          const SizedBox(height: 10),

                          BulletedListBuilder(
                              list: jobsData.responsibilities, padding: true),
                          const SizedBox(height: 10),

                          const CustomText(
                              text: 'Perks & Benefits', bold: true, size: 18),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 10,
                            children: jobsData.benefits
                                .map((item) => InfoChip(
                                      title: item,
                                      titleColor: Colors.blueGrey,
                                    ))
                                .toList(),
                          ),

                          // const SegmentedSlider(),
                          // const SizedBox(height: 5)
                        ],
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              )),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(14),
          child: ref.watch(currentApplicantDetailsProvider).when(
              data: (applicant) {
                return applicant.appliedJobs.contains(jobsData.jobId)
                    ? Theme(
                        data: Theme.of(context)
                            .copyWith(splashFactory: NoSplash.splashFactory),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                surfaceTintColor:
                                    AppColors.primaryColor.toMSP(),
                                backgroundColor: Colors.white.toMSP(),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(
                                            width: 2,
                                            color: AppColors.primaryColor)))),
                            onPressed: () {},
                            child: const CustomText(
                                text: 'Applied',
                                color: AppColors.primaryColor)),
                      )
                    : ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).push(pageRouteTransition(
                                ApplyJobView(
                                  jobDetails: jobsData,
                                  applicant: applicant,
                                ),
                                td: TransitionDirection.bottom)),
                        child: Text(
                          'Apply Now',
                          style: textStyle.copyWith(
                              color: Colors.white, fontSize: 17),
                        ));
              },
              error: (error, stackTrace) => const SizedBox(),
              loading: () => const SizedBox())),
    );
  }
}

/*
ElevatedButton(
            onPressed: () => Navigator.of(context).push(pageRouteTransition(
                ApplyJobView(
                    companyId: jobsData!.companyId, jobId: jobsData.jobId),
                td: TransitionDirection.bottom)),
            child: Text(
              'Apply Now',
              style: textStyle.copyWith(color: Colors.white, fontSize: 17),
            )),
*/
class BulletedListBuilder extends StatelessWidget {
  final List<String> list;
  final bool padding;
  const BulletedListBuilder({
    Key? key,
    required this.list,
    this.padding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: list
          .map((item) => Padding(
                padding: EdgeInsets.only(bottom: padding ? 8 : 0),
                child: ListTile(
                    dense: true,
                    minVerticalPadding: 0,
                    leading: const CustomText(
                        text: '•', color: AppColors.primaryColor, size: 25),
                    title: CustomText(text: item, size: 15)),
              ))
          .toList(),
    );
  }
}
