import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/apis/auth_api.dart';
import 'package:jobhunt_pro/apis/cloud_storage_api.dart';
import 'package:jobhunt_pro/apis/database_api.dart';
import 'package:jobhunt_pro/core/resuables/file_url.dart';
import 'package:jobhunt_pro/features/authentication/screens/home.dart';
import 'package:jobhunt_pro/model/applicant.dart';
import 'package:jobhunt_pro/model/recruiter.dart';

import '../screens/second_home.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authApiProvider),
      databaseAPI: ref.watch(databaseAPIProvider),
      storageAPI: ref.watch(storageAPIProvider));
});

final currentUserProvider = FutureProvider((ref) async {
  final user = ref.watch(authApiProvider);
  return await user.getAccountInfo();
});

final currentRecruiterDetailsProvider = FutureProvider((ref) async {
  final userId = ref.watch(currentUserProvider).value!;
  final userDetails = await ref
      .watch(authControllerProvider.notifier)
      .recruiterProfile(id: userId.$id);
  return userDetails;
});

final currentApplicantDetailsProvider = FutureProvider((ref) async {
  final userId = ref.watch(currentUserProvider).value!;
  final userDetails = await ref
      .watch(authControllerProvider.notifier)
      .applicantProfile(id: '646d15cadab0402ea029');
  return userDetails;
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final DatabaseAPI _databaseAPI;
  final StorageAPI _storageAPI;
  AuthController({
    required AuthAPI authAPI,
    required DatabaseAPI databaseAPI,
    required StorageAPI storageAPI,
  })  : _authAPI = authAPI,
        _databaseAPI = databaseAPI,
        _storageAPI = storageAPI,
        super(false);

  void recruiterSignUp({
    required String companyName,
    required String websiteLink,
    required String email,
    required String twitter,
    required String linkedIn,
    required String facebook,
    required String about,
    required String password,
    required File file,
    required BuildContext context,
  }) async {
    state = true;
     var nav = Navigator.of(context);
    String uploadedFileId = await _storageAPI.uploadFile(file: file, isCv: false);
    String fileUrl = FileUrl.fileUrl(fileId: uploadedFileId,isCv: false);
    Recruiter recruiter = Recruiter(
      companyName: companyName,
      websiteLink: websiteLink,
      email: email,
      twitter: twitter,
      linkedIn: linkedIn,
      facebook: facebook,
      about: about,
      logoUrl: fileUrl,
      id: '',
    );
    final res = await _authAPI.recruiterSignUp(email: email, password: password);
    state = false;
    res.fold((l) {
      print(l.errorMsg);
    }, (r) async {
      final databaseRes =
          await _databaseAPI.saveRecruiterDetails(recruiter: recruiter, id: r.$id);
      databaseRes.fold((l) {
        print(l.errorMsg);
      }, (r) {
        print(r.data);
        nav.push(MaterialPageRoute(builder: (context) => const HomePage()));
      });
    });
  }

  void applicantSignUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    Applicant applicant = Applicant(
      name: name,
      email: email,
      skills: [],
      techStacks: [],
      about: '',
      profilePicture: '',
      id: '',
    );
    var nav = Navigator.of(context);
    final res = await _authAPI.applicantSignUp(email: email, password: password);
    state = false;
    res.fold((l) {
      print(l.errorMsg);
    }, (r) async {
      final databaseRes =
          await _databaseAPI.saveApplicantDetails(applicant: applicant, id: r.$id);
      databaseRes.fold((l) {
        print(l.errorMsg);
      }, (r) {
        print(r.data);
        nav.push(MaterialPageRoute(builder: (context) => const HomePage()));
      });
    });
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final nav = Navigator.of(context);
    state = true;
    final loginRes = await _authAPI.signIn(email: email, password: password);
    loginRes.fold((l) {
      print(l.errorMsg);
    }, (r) async {
      final accountInfo = await _authAPI.getAccountInfo();
      return switch (accountInfo.name) {
        'Applicant' => nav.push(MaterialPageRoute(
            builder: (context) => const HomePage())), //home page of Applicant
        'Recruiter' => nav.push(MaterialPageRoute(
            builder: (context) => const EHomePage())), //home page of Recruiter
        _ => const Scaffold(
            body: Center(
              child: Text("Unexpected Error, I have no idea🤣🤣"),
            ),
          ),
      };
    });
  }

  Future<Recruiter> recruiterProfile({required String id}) async {
    final details = await _databaseAPI.getRecruiterProfile(id: id);
    return Recruiter.fromMap(details.data);
  }

  Future<Applicant> applicantProfile({required String id}) async {
    final details = await _databaseAPI.getApplicantProfile(id: id);
    return Applicant.fromMap(details.data);
  }
}
