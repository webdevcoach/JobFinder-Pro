import '../../model/post_job.dart';

extension SortPostJobsByDate on List<PostJob> {
  List<PostJob> sortByDate() {
    List<PostJob> sortedList = List.from(this);
    sortedList.sort((a, b) => b.time.compareTo(a.time));
    return sortedList;
  }
}
