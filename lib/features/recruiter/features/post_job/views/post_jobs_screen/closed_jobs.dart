import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/core/extensions/sort_job_by_date.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/views/post_jobs_screen/widgets/job_card.dart';

import '../../controller/post_job_controller.dart';

class ClosedJobsView extends ConsumerWidget {
  const ClosedJobsView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final activeJobs = ref.watch(postedJobProvider);

    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
        child: activeJobs.when(
          data: (data) {
            final activeJobs = data.sortByDate();

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (BuildContext context, int index) {
                final job = activeJobs[index];
                return job.isOpened
                    ? const SizedBox.shrink()
                    : JobCard(
                        job:job ,
                      );
              },
            );
          },
          error: (error, st) {
            print(error);
            return Text('Error: $st');
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
