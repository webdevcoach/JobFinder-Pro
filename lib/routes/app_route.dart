import 'package:flutter/material.dart';

import '../features/recruiter/features/post_job/views/post_jobs_screen/post_a_job_view.dart';
import '../features/recruiter/features/post_job/views/post_jobs_screen/posted_job_detail_view.dart';
import '../features/recruiter/features/post_job/views/view_applicants/view_applicants_view.dart';

class AppRoute {
  static const String postedJobDetailsView = 'posted-job-detail-view';
  static const String postAJobView = 'post-a-job-view';
  static const String viewApplicants = 'view-applicants-view';
  static toPage(Widget page) => MaterialPageRoute(builder: (context) => page);

  static Route<dynamic> generatedRoute(RouteSettings routeSettings) {
    dynamic routeObject;
    if (routeSettings.arguments != null) {
      routeObject = routeSettings.arguments;
    }
    return switch (routeSettings.name) {
      postedJobDetailsView => toPage(PostedJobDetailView(job: routeObject)),
      postAJobView => toPage(const PostAJobView()),
      viewApplicants => toPage(ViewApplicantsView(applicantId: routeObject,)),
      _ => MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(
                  child: Text('Wrong route'),
                ),
              )),
    };
  }
}
