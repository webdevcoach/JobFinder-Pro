import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/common/searchbox.dart';
import 'package:jobhunt_pro/common/selectable_buttons.dart';
import 'package:jobhunt_pro/features/applicant/features/apply_job/views/applied_job_status.dart';

import '../../../authentication/controller/auth_controller.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const SearchBox(showFilterButton: false, isHome: false),
              const SizedBox(height: 20),
              SelectableButtons(
                
                  buttonList: const ['Review', 'Accepted', 'Rejected'],
                  selectedIndex: 0),
            ],
          ),
        ),
        Expanded(
          child: ref.watch(currentApplicantDetailsProvider).when(
              data: (profile) {
                return ListView.builder(
                    itemCount: profile.applications.length,
                    itemBuilder: (context, index) {
                      final applicationId =
                          profile.applications.reversed.toList()[index];
                      return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: AppliedJobStatus(
                            applicationId: applicationId,
                          ));
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
