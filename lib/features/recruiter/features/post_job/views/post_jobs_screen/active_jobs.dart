import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/views/post_jobs_screen/widgets/job_card.dart';

class ActiveJobsView extends ConsumerWidget {
  const ActiveJobsView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final activeJobs = ref.watch(currentRecruiterDetailsProvider);

    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
        child: activeJobs.when(
          data: (profile) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profile.postedJobs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (BuildContext context, int index) {
                final job = profile.postedJobs.reversed.toList()[index];
                return JobCard(
                  isApplicant: false,
                  postedJobsId: job,
                );
              },
            );
          },
          error: (error, st) {
            return const SizedBox();
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
