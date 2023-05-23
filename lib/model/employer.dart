// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class Employer {
  final String companyName;
  final String websiteLink;
  final String email;
  final String twitter;
  final String linkedIn;
  final String facebook;
  final String about;
  final String logoUrl;
  final String id;
  Employer({
    required this.companyName,
    required this.websiteLink,
    required this.email,
    required this.twitter,
    required this.linkedIn,
    required this.facebook,
    required this.about,
    required this.logoUrl,
    required this.id,
  });

  Employer copyWith({
    String? companyName,
    String? websiteLink,
    String? email,
    String? twitter,
    String? linkedIn,
    String? facebook,
    String? about,
    String? logoUrl,
    String? id,
  }) {
    return Employer(
      companyName: companyName ?? this.companyName,
      websiteLink: websiteLink ?? this.websiteLink,
      email: email ?? this.email,
      twitter: twitter ?? this.twitter,
      linkedIn: linkedIn ?? this.linkedIn,
      facebook: facebook ?? this.facebook,
      about: about ?? this.about,
      logoUrl: logoUrl ?? this.logoUrl,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyName': companyName,
      'websiteLink': websiteLink,
      'email': email,
      'twitter': twitter,
      'linkedIn': linkedIn,
      'facebook': facebook,
      'about': about,
      'logoUrl': logoUrl,

    };
  }

  factory Employer.fromMap(Map<String, dynamic> map) {
    return Employer(
      companyName: map['companyName'] as String,
      websiteLink: map['websiteLink'] as String,
      email: map['email'] as String,
      twitter: map['twitter'] as String,
      linkedIn: map['linkedIn'] as String,
      facebook: map['facebook'] as String,
      about: map['about'] as String,
      logoUrl: map['logoUrl'] as String,
      id: map['\$id'] as String,
    );
  }

  @override
  String toString() {
    return 'Employer(companyName: $companyName, websiteLink: $websiteLink, email: $email, twitter: $twitter, linkedIn: $linkedIn, facebook: $facebook, about: $about, logoUrl: $logoUrl, id: $id)';
  }

  @override
  bool operator ==(covariant Employer other) {
    if (identical(this, other)) return true;
  
    return 
      other.companyName == companyName &&
      other.websiteLink == websiteLink &&
      other.email == email &&
      other.twitter == twitter &&
      other.linkedIn == linkedIn &&
      other.facebook == facebook &&
      other.about == about &&
      other.logoUrl == logoUrl &&
      other.id == id;
  }

  @override
  int get hashCode {
    return companyName.hashCode ^
      websiteLink.hashCode ^
      email.hashCode ^
      twitter.hashCode ^
      linkedIn.hashCode ^
      facebook.hashCode ^
      about.hashCode ^
      logoUrl.hashCode ^
      id.hashCode;
  }


}
