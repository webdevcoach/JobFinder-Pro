// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Employee {
  final String name;
  final String email;
  final List<String> skills;
  final List<String> techStacks;
  final String about;
  final String profilePicture;
  Employee({
    required this.name,
    required this.email,
    required this.skills,
    required this.techStacks,
    required this.about,
    required this.profilePicture,
  });

  Employee copyWith({
    String? name,
    String? email,
    List<String>? skills,
    List<String>? techStacks,
    String? about,
    String? profilePicture,
  }) {
    return Employee(
      name: name ?? this.name,
      email: email ?? this.email,
      skills: skills ?? this.skills,
      techStacks: techStacks ?? this.techStacks,
      about: about ?? this.about,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'skills': skills,
      'techStacks': techStacks,
      'about': about,
      'profilePicture': profilePicture,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      name: map['name'] as String,
      email: map['email'] as String,
      skills: List<String>.from(map['skills']),
      techStacks: List<String>.from(map['techStacks']),
      about: map['about'] as String,
      profilePicture: map['profilePicture'] as String,
    );
  }


  @override
  String toString() {
    return 'Employee(name: $name, email: $email, skills: $skills, techStacks: $techStacks, about: $about, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(covariant Employee other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.name == name &&
      other.email == email &&
      listEquals(other.skills, skills) &&
      listEquals(other.techStacks, techStacks) &&
      other.about == about &&
      other.profilePicture == profilePicture;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      skills.hashCode ^
      techStacks.hashCode ^
      about.hashCode ^
      profilePicture.hashCode;
  }
}
