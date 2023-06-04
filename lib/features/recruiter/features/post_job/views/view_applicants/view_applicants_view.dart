import 'package:flutter/material.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/views/view_applicants/applicant_card.dart';

class ViewApplicantsView extends StatelessWidget {
  final List<String> applicantId;
  const ViewApplicantsView({super.key, required this.applicantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('View Applicants')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: applicantId.length,
              itemBuilder: (context, index) {
                return ApplicantCard(applicationId: applicantId[index]);
              }),
        ));
  }
}
