import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/apis/cloud_storage_api.dart';
import 'package:jobhunt_pro/model/apply_job.dart';

class AppliedApplicantDetails extends ConsumerStatefulWidget {
  final ApplyJob applyJob;
  const AppliedApplicantDetails({super.key, required this.applyJob});

  @override
  ConsumerState<AppliedApplicantDetails> createState() =>
      _AppliedApplicantDetailsState();
}

class _AppliedApplicantDetailsState
    extends ConsumerState<AppliedApplicantDetails> {
  @override
  Widget build(BuildContext context) {
    final details = widget.applyJob;
    return Scaffold(
      appBar: AppBar(title: const Text('Applicant  Details')),
      body: Column(
        children: [
          const SizedBox(
            height: 120,
          ),
          Text(details.status.text),
          Text(details.applicantId),
          Text(details.applicationId),
          Text(details.coverLetter),
          TextButton(
              onPressed: () async {
                ///test
                final file = await ref
                    .watch(storageAPIProvider)
                    .viewCv(fileId: details.cvId);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Scaffold(
                              body: PDFView(filePath: file),
                            )));
              },
              child: const Text('VIEW CV')),
          Text(details.companyId),
          Text(details.cvId),
          Text(details.appliedTime.toString()),
        ],
      ),
    );
  }
}
