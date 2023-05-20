import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/apis/auth_api.dart';
import 'package:jobhunt_pro/model/employee.dart';
import 'package:jobhunt_pro/model/employer.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(api: ref.watch(authApiProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI api})
      : _authAPI = api,
        super(false);

  void employerSignUp() async {
    state = true;
    Employer employer = Employer(
      companyName: 'companyName',
      websiteLink: 'websiteLink',
      email: 'email',
      twitter: 'twitter',
      linkedIn: 'linkedIn',
      facebook: 'facebook',
      about: 'about',
      logoUrl: 'logoUrl',
    );
    final res = await _authAPI.employerSignUp(employer: employer);
    state = false;
    res.fold((l) => null, (r) => null);
  }

  void employeeSignUp() async {
    state = true;
    Employee employee = Employee(
      name: 'name',
      email: 'email',
      skills: [],
      techStacks: [],
      about: 'about',
      profilePicture: 'profilePicture',
    );
    final res = await _authAPI.employeeSignUp(employee: employee);
    state = false;
    res.fold((l) => null, (r) => null);
  }
}
