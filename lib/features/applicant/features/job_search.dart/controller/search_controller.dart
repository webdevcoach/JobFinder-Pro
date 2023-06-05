import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/apis/database_api.dart';
import 'package:jobhunt_pro/model/post_job.dart';

final searchControllerProvider = StateNotifierProvider<SearchController, bool>((ref) {
  return SearchController(databaseAPI: ref.watch(databaseAPIProvider));
});

final jobSearchProvider = FutureProvider.family((ref, String keyword) async {
  final jobs =
      ref.watch(searchControllerProvider.notifier).jobQuery(keyword: keyword);
  return jobs;
});
class SearchController extends StateNotifier<bool> {
  final DatabaseAPI _databaseAPI;
  SearchController({
    required DatabaseAPI databaseAPI,
  })  : _databaseAPI = databaseAPI,
        super(false);

  Future<List<PostJob>> jobQuery({required String keyword}) async {
    final result = await _databaseAPI.searchJobs(keyword: keyword);
    return result.map((document) => PostJob.fromMap(document.data)).toList();
  }
}
