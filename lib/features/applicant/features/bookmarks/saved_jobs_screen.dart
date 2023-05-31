// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/views/post_jobs_screen/widgets/job_card.dart';

import '../../../../common/custom_appbar.dart';

class SavedJobsScreen extends ConsumerWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme.displayLarge;

    // final savedJobs = jobsData.where((job) => job.isSaved == true).toList();

    return Scaffold(
      appBar: CustomAppBar(title: 'Saved', showSuffixIcon: false),
      body: ref.watch(currentApplicantDetailsProvider).when(
          data: (profile) {
            return ListView.builder(
                itemCount: profile.appliedJobs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: JobCard(
                        isApplicant: true,
                        postedJobsId: profile.appliedJobs[index]),
                  );
                });
          },
          error: (error, trace) => const SizedBox(),
          loading: () => const CircularProgressIndicator()),
      /* ListView(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                // Text(
                //   'You saved ${savedJobs.length} jobs',
                //   style: textStyle!.copyWith(fontSize: 22),
                // ),
                SizedBox(height: 20),
                // SelectableButtons(
                //   buttonList: savedScreenSelectableButtonText,
                //   selectedIndex: 1,
                // ),
              ],
            ),
          ),
          // ListView.builder(
          //   physics: const NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   itemCount: savedJobs.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return SavedJobCard(
          //       id: savedJobs[index].id,
          //       type: savedJobs[index].type,
          //       title: savedJobs[index].title,
          //       isBookmarked: savedJobs[index].isSaved,
          //       location: savedJobs[index].location,
          //       imageUrl: savedJobs[index].imageUrl,
          //       imageBackground: savedJobs[index].imageBackground,
          //     );
          //   },
          // ),
          SizedBox(height: 20)
        ],
      ),*/
    );
  }
}
