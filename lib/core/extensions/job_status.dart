
import 'package:jobhunt_pro/core/enums/application_status.dart';

extension JobType on String {
  ApplicationStatus applicationStatus(){
    return switch(this){
     'review'=> ApplicationStatus.review,
     'accepted' => ApplicationStatus.accepted,
     'rejected'=> ApplicationStatus.rejected,
      _=> ApplicationStatus.review,
    };
  }
}