import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/common/searchbox.dart';
import 'package:jobhunt_pro/features/applicant/features/apply_job/views/applied_job_status.dart';

import '../../../authentication/controller/auth_controller.dart';
import '../../../recruiter/features/post_job/views/post_jobs_screen/widgets/job_card.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity')),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              SearchBox(showFilterButton: false, isHome: false),
              SizedBox(height: 20),
              // SelectableButtons(
              //     buttonList: activityScreenSelectableButtonText,
              //     selectedIndex: 0),
            ],
          ),
        ),
        Expanded(
          child: ref.watch(currentApplicantDetailsProvider).when(
              data: (profile) {
                return ListView.builder(
                    itemCount: profile.applications.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: AppliedJobStatus(jobId: profile.applications[index])
                      );
                    });
              },
              error: (error, trace) => SizedBox(
                    child: Text(error.toString()),
                  ),
              loading: () => const CircularProgressIndicator()),
        ),
        // ListView.builder(
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   itemCount: jobsData.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return ActivityCard(
        //       id: jobsData[index].id,
        //       type: jobsData[index].type,
        //       title: jobsData[index].title,
        //       salary: jobsData[index].salary,
        //       company: jobsData[index].company,
        //       location: jobsData[index].location,
        //       imageUrl: jobsData[index].imageUrl,
        //       imageBackground: jobsData[index].imageBackground,
        //     );
        //   },
        // ),
      ]),
    );
  }
}
