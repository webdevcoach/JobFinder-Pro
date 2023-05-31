// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:jobhunt_pro/core/extensions/job_status.dart';

import '../core/enums/application_status.dart';

class ApplyJob {
  final String applicantId;
  final String coverLetter;
  final String cvUrl;
  final String applicationId;
  final String companyId;
  final DateTime appliedTime;
  final ApplicationStatus status;
  ApplyJob({
    required this.applicantId,
    required this.coverLetter,
    required this.cvUrl,
    required this.applicationId,
    required this.companyId,
    required this.appliedTime,
    required this.status,
  });

  ApplyJob copyWith({
    String? applicantId,
    String? coverLetter,
    String? cvUrl,
    String? applicationId,
    String? companyId,
    DateTime? appliedTime,
    ApplicationStatus? status,
  }) {
    return ApplyJob(
      applicantId: applicantId ?? this.applicantId,
      coverLetter: coverLetter ?? this.coverLetter,
      cvUrl: cvUrl ?? this.cvUrl,
      applicationId: applicationId ?? this.applicationId,
      companyId: companyId ?? this.companyId,
      appliedTime: appliedTime ?? this.appliedTime,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'applicantId': applicantId,
      'coverLetter': coverLetter,
      'cvUrl': cvUrl,
      'companyId': companyId,
      'appliedTime': appliedTime.millisecondsSinceEpoch,
      'status': status.text,
    };
  }

  factory ApplyJob.fromMap(Map<String, dynamic> map) {
    return ApplyJob(
      applicantId: map['applicantId'] as String,
      coverLetter: map['coverLetter'] as String,
      cvUrl: map['cvUrl'] as String,
      applicationId: map['\$id'] as String,
      companyId: map['companyId'] as String,
      appliedTime: DateTime.fromMillisecondsSinceEpoch(map['appliedTime'] as int),
      status:(map['status'] as String).applicationStatus(),
    );
  }

  @override
  String toString() {
    return 'ApplyJob(applicantId: $applicantId, coverLetter: $coverLetter, cvUrl: $cvUrl, applicationId: $applicationId, companyId: $companyId, appliedTime: $appliedTime, status: $status)';
  }

  @override
  bool operator ==(covariant ApplyJob other) {
    if (identical(this, other)) return true;
  
    return 
      other.applicantId == applicantId &&
      other.coverLetter == coverLetter &&
      other.cvUrl == cvUrl &&
      other.applicationId == applicationId &&
      other.companyId == companyId &&
      other.appliedTime == appliedTime &&
      other.status == status;
  }

  @override
  int get hashCode {
    return applicantId.hashCode ^
      coverLetter.hashCode ^
      cvUrl.hashCode ^
      applicationId.hashCode ^
      companyId.hashCode ^
      appliedTime.hashCode ^
      status.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory ApplyJob.fromJson(String source) => ApplyJob.fromMap(json.decode(source) as Map<String, dynamic>);
}
