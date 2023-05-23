import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/apis/database_api.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';
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
    required double salary,
    required List<String> responsibilities,
    required List<String> requirement,
    required List<String> benefits,
    required WidgetRef ref,
  }) async {
    state = JobState.loading;
    final employer = ref.watch(currentEmployerDetailsProvider).value!;
    PostJob jobDetails = PostJob(
      jobTitle: jobTitle,
      workingMode: workingMode,
      description: description,
      location: location,
      jobType: jobType,
      time: DateTime.now(),
      jobId: '',
      isOpened: false,
      companyId: employer.id,
      appliedCandidates: [],
      salary: 40.0,
      responsibilities: responsibilities,
      requirement: requirement,
      benefits: benefits,
    );
    final job = await _databaseAPI.postJob(jobDetails: jobDetails);
    state = JobState.initialState;
    job.fold((l) {
      //failure
      print(l.errorMsg);
    }, (r) {
      //success
      print(r.data);
    });
  }

  Future<List<PostJob>> getJobs() async {
    final jobs = await _databaseAPI.getPostedJobs();
    return jobs.map((job) => PostJob.fromMap(job.data)).toList();
  }
}
