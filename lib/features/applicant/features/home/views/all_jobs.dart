import 'package:flutter/material.dart';
import 'package:jobhunt_pro/features/applicant/features/job_detail/job_detail_screen.dart';
import 'package:jobhunt_pro/model/job.dart';

import '../../../../../common/route_transition.dart';
import '../widgets/recent_job_card.dart';

class AllJobsList extends StatelessWidget {
  final List<Job> jobs;
  const AllJobsList({
    super.key,
    required this.jobs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Jobs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            final job = jobs[index];
            bool status = job.isOpened;
            return status
                ? RecentJobCard(
                  
                    job: job,
                    imageBackground: Colors.transparent,
                  )
                : const SizedBox();
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        ),
      ),
    );
  }
}
