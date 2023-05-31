import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/custom_forms_kit.dart';
import '../controller/auth_controller.dart';
import '../widgets/custom_auth_field.dart';

class RecruiterLoginSection extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const RecruiterLoginSection(),
      );
  const RecruiterLoginSection({super.key});

  @override
  ConsumerState<RecruiterLoginSection> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<RecruiterLoginSection> {
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
                    hintText: 'Email',
                  ),
                  CustomAuthField(
                    controller: passwordController,
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: onLogin,
                      child: CustomText(text: 'Log in', color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
  }
}
