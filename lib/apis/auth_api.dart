
import 'dart:html';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/core/type_def.dart';
import 'package:appwrite/models.dart' as model;
import 'package:jobhunt_pro/model/employee.dart';
import 'package:jobhunt_pro/model/employer.dart';

import 'appwrite_injects.dart';

final authApiProvider = Provider((ref) {
  return AuthAPI(account: ref.watch(authProvider));
});

abstract class AuthInterface{
  FutureEither<model.User> employerSignUp({required Employer employer});
  FutureEither<model.User> employeeSignUp({required Employee employee});
}


class AuthAPI implements AuthInterface{
  final  Account _account;
  AuthAPI({required Account account}): _account =account;
  @override
  FutureEither<model.User> employeeSignUp({required Employee employee}) {
    // TODO: implement employeeSignUp

    throw UnimplementedError();
  }

  @override
  FutureEither<model.User> employerSignUp({required Employer employer}) {
    // TODO: implement employerSignUp
    throw UnimplementedError();
  }

}