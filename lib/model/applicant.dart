// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Applicant {
  final String name;
  final String email;
  final List<String> skills;
  final List<String> techStacks;
  final String about;
  final String profilePicture;
  final String id;
  Applicant({
    required this.name,
    required this.email,
    required this.skills,
    required this.techStacks,
    required this.about,
    required this.profilePicture,
    required this.id,
  });

  Applicant copyWith({
    String? name,
    String? email,
    List<String>? skills,
    List<String>? techStacks,
    String? about,
    String? profilePicture,
    String? id,
  }) {
    return Applicant(
      name: name ?? this.name,
      email: email ?? this.email,
      skills: skills ?? this.skills,
      techStacks: techStacks ?? this.techStacks,
      about: about ?? this.about,
      profilePicture: profilePicture ?? this.profilePicture,
      id: id ?? this.id,
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

  factory Applicant.fromMap(Map<String, dynamic> map) {
    return Applicant(
      name: map['name'] as String,
      email: map['email'] as String,
      skills: List<String>.from(map['skills'] ),
      techStacks: List<String>.from(map['techStacks'] ),
      about: map['about'] as String,
      profilePicture: map['profilePicture'] as String,
      id: map['\$id'] as String,
    );
  }


  @override
  String toString() {
    return 'Applicant(name: $name, email: $email, skills: $skills, techStacks: $techStacks, about: $about, profilePicture: $profilePicture, id: $id)';
  }

  @override
  bool operator ==(covariant Applicant other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.name == name &&
      other.email == email &&
      listEquals(other.skills, skills) &&
      listEquals(other.techStacks, techStacks) &&
      other.about == about &&
      other.profilePicture == profilePicture &&
      other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      skills.hashCode ^
      techStacks.hashCode ^
      about.hashCode ^
      profilePicture.hashCode ^
      id.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Applicant.fromJson(String source) => Applicant.fromMap(json.decode(source) as Map<String, dynamic>);
}
