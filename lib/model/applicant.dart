// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:collection/collection.dart';

class Applicant {
  final String name;
  final String email;
  final List<String> skills;
  final String title;
  final List<String> experience;
  final String about;
  final String location;
  final String profilePicture;
  final String id;
  final List<String> appliedJobs;
  final List<String> savedJobs;
  Applicant({
    required this.name,
    required this.email,
    required this.skills,
    required this.title,
    required this.experience,
    required this.about,
    required this.location,
    required this.profilePicture,
    required this.id,
    required this.appliedJobs,
    required this.savedJobs,
  });

  Applicant copyWith({
    String? name,
    String? email,
    List<String>? skills,
    String? title,
    List<String>?  experience,
    String? about,
    String? location,
    String? profilePicture,
    String? id,
    List<String>? appliedJobs,
    List<String>? savedJobs,
  }) {
    return Applicant(
      name: name ?? this.name,
      email: email ?? this.email,
      skills: skills ?? this.skills,
      title: title ?? this.title,
      experience: experience ?? this.experience,
      about: about ?? this.about,
      location: location ?? this.location,
      profilePicture: profilePicture ?? this.profilePicture,
      id: id ?? this.id,
      appliedJobs: appliedJobs ?? this.appliedJobs,
      savedJobs: savedJobs ?? this.savedJobs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'skills': skills,
      'title': title,
      'experience': experience,
      'about': about,
      'location': location,
      'profilePicture': profilePicture,
      'appliedJobs': appliedJobs,
      'savedJobs': savedJobs,
    };
  }

  factory Applicant.fromMap(Map<String, dynamic> map) {
    return Applicant(
      name: map['name'] as String,
      email: map['email'] as String,
      skills: List<String>.from(map['skills'] ),
      title: map['title'] as String,
      experience: List<String>.from(map['experience'] ),
      about: map['about'] as String,
      location: map['location'] as String,
      profilePicture: map['profilePicture'] as String,
      id: map['\$id'] as String,
      appliedJobs: List<String>.from(map['appliedJobs'] ),
      savedJobs: List<String>.from(map['savedJobs'] ),
    );
  }

  @override
  String toString() {
    return 'Applicant(name: $name, email: $email, skills: $skills, title: $title, experience: $experience, about: $about, location: $location, profilePicture: $profilePicture, id: $id, appliedJobs: $appliedJobs, savedJobs: $savedJobs)';
  }

  @override
  bool operator ==(covariant Applicant other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.name == name &&
      other.email == email &&
      listEquals(other.skills, skills) &&
      other.title == title &&
      other.experience == experience &&
      other.about == about &&
      other.location == location &&
      other.profilePicture == profilePicture &&
      other.id == id &&
      listEquals(other.appliedJobs, appliedJobs) &&
      listEquals(other.savedJobs, savedJobs);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      skills.hashCode ^
      title.hashCode ^
      experience.hashCode ^
      about.hashCode ^
      location.hashCode ^
      profilePicture.hashCode ^
      id.hashCode ^
      appliedJobs.hashCode ^
      savedJobs.hashCode;
  }

 

}
