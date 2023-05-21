import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/apis/auth_api.dart';
import 'package:jobhunt_pro/apis/database_api.dart';
import 'package:jobhunt_pro/model/employee.dart';
import 'package:jobhunt_pro/model/employer.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authApiProvider),
      databaseAPI: ref.watch(databaseAPIProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final DatabaseAPI _databaseAPI;
  AuthController({required AuthAPI authAPI, required DatabaseAPI databaseAPI})
      : _authAPI = authAPI,
        _databaseAPI = databaseAPI,
        super(false);

  void employerSignUp({
    required String companyName,
    required String websiteLink,
    required String email,
    required String twitter,
    required String linkedIn,
    required String password,
  }) async {
    state = true;
    Employer employer = Employer(
      companyName: companyName,
      websiteLink: 'websiteLink',
      email: 'email',
      twitter: 'twitter',
      linkedIn: 'linkedIn',
      facebook: 'facebook',
      about: 'about',
      logoUrl: 'logoUrl',
    );
    final res = await _authAPI.employerSignUp(email: email, password: password);
    state = false;
    res.fold((l) {
      print(l.errorMsg);
    }, (r) async {
      final databaseRes =
          await _databaseAPI.saveEmployerDetails(employer: employer, id: r.$id);
      databaseRes.fold((l) {}, (r) {
        //navigate to home
      });
    });
  }

  void employeeSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = true;
    Employee employee = Employee(
      name: name,
      email: email,
      skills: [],
      techStacks: [],
      about: '',
      profilePicture: '',
    );
    final res = await _authAPI.employeeSignUp(email: email, password: password);
    state = false;
    res.fold((l) => null, (r) async {
      final databaseRes =
          await _databaseAPI.saveEmployeeDetails(employee: employee,id: r.$id);
      databaseRes.fold((l) {
        //error alert
      }, (r) {
        // Navigate to login screen
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
    loginRes.fold((l) => null, (r) async {
      final accountInfo = await _authAPI.getAccountInfo();
      return switch (accountInfo.name) {
        'Employee' => nav.push(MaterialPageRoute(
            builder: (context) => const Scaffold())), //home page of employee
        'Employer' => nav.push(MaterialPageRoute(
            builder: (context) => const Scaffold())), //home page of employer
        _ => '',
      };
    });
  }
}
