import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/apis/cloud_storage_api.dart';
import 'package:jobhunt_pro/apis/database_api.dart';
import 'package:jobhunt_pro/core/enums/application_status.dart';
import 'package:jobhunt_pro/core/resuables/file_url.dart';
import 'package:jobhunt_pro/model/applicant.dart';
import 'package:jobhunt_pro/model/apply_job.dart';
import 'package:jobhunt_pro/model/post_job.dart';
import 'package:uuid/uuid.dart';

import '../../../../../common/route_transition.dart';
import '../../../../authentication/controller/auth_controller.dart';
import '../../home/views/page_navigator.dart';

enum ApplyJobState {
  initialState,
  loading,
}

final applyJobControllerProvider =
    StateNotifierProvider<ApplyJobController, ApplyJobState>((ref) {
  return ApplyJobController(
      databaseAPI: ref.watch(databaseAPIProvider),
      storageAPI: ref.watch(storageAPIProvider));
});

class ApplyJobController extends StateNotifier<ApplyJobState> {
  final DatabaseAPI _databaseAPI;
  final StorageAPI _storageAPI;
  ApplyJobController({
    required DatabaseAPI databaseAPI,
    required StorageAPI storageAPI,
  })  : _databaseAPI = databaseAPI,
        _storageAPI = storageAPI,
        super(ApplyJobState.initialState);

  void applyJob({
    required BuildContext context,
    required File cv,
    required String coverLetter,
    required String jobId,
    required WidgetRef ref,
    required Applicant applicant,
    required PostJob selectedJob,
  }) async {
    state = ApplyJobState.loading;
    final nav = Navigator.of(context);
    String applicationId = const Uuid().v1();
    String fileId = await _storageAPI.uploadFile(file: cv, isCv: true);
    String cvUrl = FileUrl.fileUrl(fileId: fileId, isCv: true);
    final applicant = ref.watch(currentApplicantDetailsProvider).value;
    if (applicant == null) {
      return;
    }
    List<String> applyJobsList = applicant.appliedJobs;
    applyJobsList.add(selectedJob.jobId);
    final updatedApplicantDetails =
        applicant.copyWith(appliedJobs: applyJobsList);
    List<String> applicationList = selectedJob.applicationReceived;
    applicationList.add(applicationId);
    final updatedJobDetails =
        selectedJob.copyWith(applicationReceived: applicationList);

    ApplyJob applicantInfo = ApplyJob(
      applicantId: applicant.id,
      coverLetter: coverLetter,
      cvUrl: cvUrl,
      companyId: selectedJob.companyId,
      applicationId: applicationId,
      appliedTime: DateTime.now(),
      status: ApplicationStatus.review,
    );
    final apply = await _databaseAPI.applyJob(applyJob: applicantInfo);

    apply.fold((l) {
      print(l.errorMsg);
    }, (r) async {
       state = ApplyJobState.initialState;
      await _databaseAPI.updateApplicantProfileWithJobId(
          applicant: updatedApplicantDetails);
      final res =
          await _databaseAPI.updateJobWithApplicationId(job: updatedJobDetails);
      res.fold(
        (l) => print(l.errorMsg),
        (r) => nav.pushAndRemoveUntil(
            pageRouteTransition(const ApplicantPageNavigator()),
            (route) => false),
      );
    });
  }

  void saveJob({required Applicant applicant, required String jobId})async{
    List<String> savedJobsList =  applicant.savedJobs;
    if(!savedJobsList.contains(jobId)){
    savedJobsList.add(jobId);
    }else{
      savedJobsList.remove(jobId);
    }
    final updatedApplicantDetails = applicant.copyWith(savedJobs: savedJobsList);
    final job  = await _databaseAPI.saveJob(applicant: updatedApplicantDetails);
    job.fold((l) => print(l.errorMsg), (r) => null);
  }
}
