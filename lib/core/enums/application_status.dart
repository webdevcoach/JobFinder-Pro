 
 enum ApplicationStatus{
   review('review'),
   accepted('accepted'),
   rejected('rejected');
   final String text;
   const ApplicationStatus(this.text);
 }