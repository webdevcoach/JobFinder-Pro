import '../../model/job.dart';

extension SortPostJobsByDate on List<Job> {
  List<Job> sortByDate() {
    List<Job> sortedList = List.from(this);
    sortedList.sort((a, b) => b.time.compareTo(a.time));
    return sortedList;
  }
}
