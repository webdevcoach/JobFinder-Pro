import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/apis/cloud_storage_api.dart';
import 'package:jobhunt_pro/apis/database_api.dart';
import 'package:jobhunt_pro/core/enums/application_status.dart';
import 'package:jobhunt_pro/core/resuables/file_url.dart';
import 'package:jobhunt_pro/model/apply_job.dart';

import '../../authentication/controller/auth_controller.dart';

enum ApplyJobState {
  initialState,
  loading,
}

final applyJobControllerProvider = StateNotifierProvider<ApplyJobController, ApplyJobState>((ref) {
  return  ApplyJobController(databaseAPI: ref.watch(databaseAPIProvider), storageAPI: ref.watch(storageAPIProvider));
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
    required String companyId,
    required String jobId,
    required WidgetRef ref,
  }) async {
    state = ApplyJobState.loading;
    String fileId = await _storageAPI.uploadFile(file: cv, isCv: true);
    String cvUrl = FileUrl.fileUrl(fileId: fileId, isCv: true);
  final employee = ref.watch(currentEmployeeDetailsProvider).value!;
    ApplyJob applicantInfo = ApplyJob(
        applicantId: employee.id,
        coverLetter: coverLetter,
        cvUrl: cvUrl,
        jobId: jobId,
        companyId: companyId,
        appliedTime: DateTime.now(),
        status: ApplicationStatus.review,
        );
    final apply = await _databaseAPI.applyJob(applyJob: applicantInfo);
    state = ApplyJobState.initialState;
    apply.fold((l){
      print(l.errorMsg);
    }, (r){
      print(r.data);
    });
  }
}
