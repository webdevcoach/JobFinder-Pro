// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:collection/collection.dart';

class PostJob {
  final String jobTitle;
  final String workingMode;
  final String description;
  final String location;
  final String jobType;
  final DateTime time;
  final String jobId;
  final bool openOrClosed;
  final String companyId;
  final List<String> appliedCandidates;
  final double salary;
  final List<String> responsibilities;
  final List<String> requirement;
  final List<String> benefits;
  PostJob({
    required this.jobTitle,
    required this.workingMode,
    required this.description,
    required this.location,
    required this.jobType,
    required this.time,
    required this.jobId,
    required this.openOrClosed,
    required this.companyId,
    required this.appliedCandidates,
    required this.salary,
    required this.responsibilities,
    required this.requirement,
    required this.benefits,
  });
  //Job title
  //Remote/Onsite/hybrid'
  //description
  //location
  //Full time, internship, contract
  // responsibilities
  // requirement
  // qualification
  //Salary
  //benefits

  PostJob copyWith({
    String? jobTitle,
    String? workingMode,
    String? description,
    String? location,
    String? jobType,
    DateTime? time,
    String? jobId,
    bool? openOrClosed,
    String? companyId,
    List<String>? appliedCandidates,
    double? salary,
    List<String>? responsibilities,
    List<String>? requirement,
    List<String>? benefits,
  }) {
    return PostJob(
      jobTitle: jobTitle ?? this.jobTitle,
      workingMode: workingMode ?? this.workingMode,
      description: description ?? this.description,
      location: location ?? this.location,
      jobType: jobType ?? this.jobType,
      time: time ?? this.time,
      jobId: jobId ?? this.jobId,
      openOrClosed: openOrClosed ?? this.openOrClosed,
      companyId: companyId ?? this.companyId,
      appliedCandidates: appliedCandidates ?? this.appliedCandidates,
      salary: salary ?? this.salary,
      responsibilities: responsibilities ?? this.responsibilities,
      requirement: requirement ?? this.requirement,
      benefits: benefits ?? this.benefits,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobTitle': jobTitle,
      'workingMode': workingMode,
      'description': description,
      'location': location,
      'jobType': jobType,
      'time': time.millisecondsSinceEpoch,
      'jobId': jobId,
      'openOrClosed': openOrClosed,
      'companyId': companyId,
      'appliedCandidates': appliedCandidates,
      'salary': salary,
      'responsibilities': responsibilities,
      'requirement': requirement,
      'benefits': benefits,
    };
  }

  factory PostJob.fromMap(Map<String, dynamic> map) {
    return PostJob(
      jobTitle: map['jobTitle'] as String,
      workingMode: map['workingMode'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      jobType: map['jobType'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      jobId: map['jobId'] as String,
      openOrClosed: map['openOrClosed'] as bool,
      companyId: map['companyId'] as String,
      appliedCandidates: List<String>.from(map['appliedCandidates'] ),
      salary: map['salary'] as double,
      responsibilities: List<String>.from(map['responsibilities'] ),
      requirement: List<String>.from(map['requirement'] ),
      benefits: List<String>.from(map['benefits'] ),
    );
  }

  @override
  String toString() {
    return 'PostJob(jobTitle: $jobTitle, workingMode: $workingMode, description: $description, location: $location, jobType: $jobType, time: $time, jobId: $jobId, openOrClosed: $openOrClosed, companyId: $companyId, appliedCandidates: $appliedCandidates, salary: $salary, responsibilities: $responsibilities, requirement: $requirement, benefits: $benefits)';
  }

  @override
  bool operator ==(covariant PostJob other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.jobTitle == jobTitle &&
      other.workingMode == workingMode &&
      other.description == description &&
      other.location == location &&
      other.jobType == jobType &&
      other.time == time &&
      other.jobId == jobId &&
      other.openOrClosed == openOrClosed &&
      other.companyId == companyId &&
      listEquals(other.appliedCandidates, appliedCandidates) &&
      other.salary == salary &&
      listEquals(other.responsibilities, responsibilities) &&
      listEquals(other.requirement, requirement) &&
      listEquals(other.benefits, benefits);
  }

  @override
  int get hashCode {
    return jobTitle.hashCode ^
      workingMode.hashCode ^
      description.hashCode ^
      location.hashCode ^
      jobType.hashCode ^
      time.hashCode ^
      jobId.hashCode ^
      openOrClosed.hashCode ^
      companyId.hashCode ^
      appliedCandidates.hashCode ^
      salary.hashCode ^
      responsibilities.hashCode ^
      requirement.hashCode ^
      benefits.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory PostJob.fromJson(String source) => PostJob.fromMap(json.decode(source) as Map<String, dynamic>);
}
