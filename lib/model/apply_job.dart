// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:jobhunt_pro/model/employee.dart';

class ApplyJob {
  //will change this later
  final Employee employee;
  final String cvUrl;
  ApplyJob({
    required this.employee,
    required this.cvUrl,
  });
  

  ApplyJob copyWith({
    Employee? employee,
    String? cvUrl,
  }) {
    return ApplyJob(
      employee: employee ?? this.employee,
      cvUrl: cvUrl ?? this.cvUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employee': employee.toMap(),
      'cvUrl': cvUrl,
    };
  }

  factory ApplyJob.fromMap(Map<String, dynamic> map) {
    return ApplyJob(
      employee: Employee.fromMap(map['employee'] as Map<String,dynamic>),
      cvUrl: map['cvUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplyJob.fromJson(String source) => ApplyJob.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ApplyJob(employee: $employee, cvUrl: $cvUrl)';

  @override
  bool operator ==(covariant ApplyJob other) {
    if (identical(this, other)) return true;
  
    return 
      other.employee == employee &&
      other.cvUrl == cvUrl;
  }

  @override
  int get hashCode => employee.hashCode ^ cvUrl.hashCode;
}
