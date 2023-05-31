// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:jobhunt_pro/common/route_transition.dart';
import 'package:jobhunt_pro/theme/colors.dart';

import '../../../../common/custom_appbar.dart';
import '../../../../common/custom_forms_kit.dart';
import '../../../../core/resuables/date_format.dart';
import '../../../recruiter/features/post_job/controller/post_job_controller.dart';
import '../apply_job/views/apply_job_view.dart';

class JobDetailScreen extends ConsumerWidget {
  final String jobId;
  const JobDetailScreen({
    Key? key,
    required this.jobId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsData = ref.watch(postedJobDetailsProvider(jobId)).value;

    final textStyle = Theme.of(context).textTheme.displayLarge!;

    return Scaffold(
      appBar: CustomAppBar(
        onPrefixTap: () => Navigator.pop(context),
        prefixIcon: IconlyLight.arrow_left_2,
        title: 'Details',
        // suffixIcon:
        //     selectedJob.isSaved ? IconlyBold.bookmark : IconlyLight.bookmark,
      ),
      body: jobsData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
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
                            child: SvgPicture.asset(
                              'assets/svg/company_logos/whatsapp.svg',
                              height: 50,
                              width: 50,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomText(
                            text: jobsData.jobTitle,
                            bold: true,
                            size: 16,
                          ),
                          const SizedBox(height: 10),
                          Text(jobsData.companyId),
                          const SizedBox(height: 10),
                          Divider(color: Colors.grey.shade400),
                          const SizedBox(height: 10),
                          CustomText(text: jobsData.location),
                          const SizedBox(height: 10),
                          CustomText(
                              text: jobsData.salary,
                              color: AppColors.primaryColor),
                          const SizedBox(height: 10),
                          Text(
                              'Posted ${timeago.format(jobsData.time)}, ends in ${formatDate(jobsData.deadline)}'),
                          const SizedBox(height: 10),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      CustomText(text: 'Requirements', bold: true, size: 18),
                      const SizedBox(height: 10),

                      BulletedListBuilder(list: jobsData.requirement),
                      CustomText(
                          text: 'Responsibilities', bold: true, size: 18),
                      const SizedBox(height: 10),

                      BulletedListBuilder(list: jobsData.requirement),
                      const SizedBox(height: 10),

                      CustomText(
                          text: 'Perks & Benefits', bold: true, size: 18),
                      const SizedBox(height: 10),

                      BulletedListBuilder(
                          list: jobsData.benefits), // const SegmentedSlider(),
                      const SizedBox(height: 60)
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(14),
          child: ref.watch(currentApplicantDetailsProvider).when(
              data: (applicant) {

                return applicant.appliedJobs.contains(jobsData!.jobId)
                    ? const SizedBox()
                    : ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).push(pageRouteTransition(
                                ApplyJobView(
                                  jobDetails: jobsData!,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
  const BulletedListBuilder({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: list
          .map((item) => ListTile(
              dense: true,
              minVerticalPadding: 0,
              leading: CustomText(
                  text: '•', color: AppColors.primaryColor, size: 25),
              title: CustomText(text: item, size: 15)))
          .toList(),
    );
  }
}
