import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/apis/database_api.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';
import 'package:jobhunt_pro/model/apply_job.dart';
import 'package:jobhunt_pro/model/post_job.dart';

enum JobState {
  initialState,
  loading,
}

final postJobControllerProvider =
    StateNotifierProvider<PostJobController, JobState>((ref) {
  return PostJobController(databaseAPI: ref.watch(databaseAPIProvider));
});

final postedJobProvider = FutureProvider((ref) async {
  final jobs = ref.watch(postJobControllerProvider.notifier);
  return await jobs.getJobs();
});
final myPostedJobProvider = FutureProvider.family((ref, String jobId) async {
  final jobs = ref.watch(postJobControllerProvider.notifier);
  return await jobs.myJobs(jobId: jobId);
});

final appliedApplicantProvider = FutureProvider.family((ref, String applicationId) async {
  final jobs = ref.watch(postJobControllerProvider.notifier);
  return await jobs.appliedApplicant(applicationId: applicationId);
});

final postedJobDetailsProvider =
    FutureProvider.family((ref, String postedJobId) async {
  final jobs = await ref.watch(postJobControllerProvider.notifier).getJobs();
  final res = jobs.where((job) => postedJobId == job.jobId).toList();
  return res.first;
});

final applicantsImageProvider = FutureProvider((ref) async {
  return;
});

class PostJobController extends StateNotifier<JobState> {
  final DatabaseAPI _databaseAPI;
  PostJobController({required DatabaseAPI databaseAPI})
      : _databaseAPI = databaseAPI,
        super(JobState.initialState);

  void postJob({
    required String jobTitle,
    required String workingMode,
    required String description,
    required String location,
    required String jobType,
    required String salary,
    required List<String> responsibilities,
    required List<String> requirement,
    required List<String> benefits,
    required WidgetRef ref,
    required DateTime deadline,
    required BuildContext context,
  }) async {
    state = JobState.loading;
    final recruiter = ref.watch(currentRecruiterDetailsProvider).value;
    
    final nav = Navigator.of(context);
    if (recruiter != null) {
      List<String> postedJobIds = recruiter.postedJobs;
      PostJob jobDetails = PostJob(
          jobTitle: jobTitle,
          workingMode: workingMode,
          description: description,
          location: location,
          jobType: jobType,
          time: DateTime.now(),
          jobId: '',
          isOpened: true,
          companyId: recruiter.id,
          applicationReceived: [],         
          salary: salary,
          responsibilities: responsibilities,
          requirement: requirement,
          benefits: benefits,
          deadline: deadline);
      final job = await _databaseAPI.postJob(jobDetails: jobDetails);
      state = JobState.initialState;
      job.fold((l) {
        //failure
        print(l.errorMsg);
      }, (r) async{
       postedJobIds.add(r.$id);
       final recruiterUpdatedDetails = recruiter.copyWith(postedJobs: postedJobIds);
       await _databaseAPI.addJobIdToRecruiterProfile(recruiter: recruiterUpdatedDetails);
        print(r.data);
        nav.pop();
      });
    } else {
      print('error occured');
    }
  }

  Future<List<PostJob>> getJobs() async {
    final jobs = await _databaseAPI.getPostedJobs();
    return jobs.map((job) => PostJob.fromMap(job.data)).toList();
  }

 Future<PostJob> myJobs({required String jobId})async{
  final job = await _databaseAPI.myPostedJobs(jobId: jobId);
  final postJob = PostJob.fromMap(job.data);
  return postJob;
 } 

  Future<ApplyJob> appliedApplicant({required String applicationId})async{
  final job = await _databaseAPI.getAppliedApplicants(applicationId: applicationId);
  final postJob = ApplyJob.fromMap(job.data);
  return postJob;
 } 

}
