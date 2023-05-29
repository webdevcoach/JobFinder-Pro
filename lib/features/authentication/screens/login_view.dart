import 'package:flutter/material.dart';
import 'package:jobhunt_pro/features/authentication/screens/applicant_login_section.dart';
import 'package:jobhunt_pro/features/authentication/screens/recruiter_login_section.dart';
import 'package:jobhunt_pro/features/authentication/screens/signup_view.dart';
import 'package:jobhunt_pro/features/authentication/widgets/registration_mini_info.dart';

class LoginView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginView(),
      );
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool applicantLoginSelected = true;

  @override
  void initState() {
    super.initState();
  }

  setSelectedRadio() {
    setState(() {
      applicantLoginSelected = !applicantLoginSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context)
        .textTheme
        .displayMedium!
        .copyWith(fontSize: 27, fontWeight: FontWeight.w700);
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Text(
                  'Login to your account',
                  style: txtStyle,
                ),
                const SizedBox(height: 30),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text("Applicant"),
                        leading: Radio(
                          value: true,
                          groupValue: applicantLoginSelected,
                          onChanged: (bool? val) {
                            setSelectedRadio();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text("Recruiter"),
                        leading: Radio(
                          value: false,
                          groupValue: applicantLoginSelected,
                          onChanged: (bool? val) {
                            setSelectedRadio();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                applicantLoginSelected
                    ? const ApplicantLoginSection()
                    : const RecruiterLoginSection(),
                RegistrationMiniInfo(
                    route: SignupView.route(),
                    left: 'Don\'t have an account?',
                    right: 'Sign up'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
