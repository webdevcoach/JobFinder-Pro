import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/custom_forms_kit.dart';
import '../controller/auth_controller.dart';
import '../widgets/custom_auth_field.dart';

class ApplicantLoginSection extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ApplicantLoginSection(),
      );
  const ApplicantLoginSection({super.key});

  @override
  ConsumerState<ApplicantLoginSection> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<ApplicantLoginSection> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return isLoading
        ? const CircularProgressIndicator()
        : Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // textfield 1
                  CustomAuthField(
                    controller: emailController,
                    hintText: 'AEmail',
                  ),
                  CustomAuthField(
                    controller: passwordController,
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: onLogin,
                    child: CustomText(text: 'Log in', color: Colors.white),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
  }
}
