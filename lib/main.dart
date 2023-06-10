import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/features/authentication/screens/login_view.dart';
import 'package:jobhunt_pro/features/recruiter/features/home/views/page_navigator.dart';
import 'package:jobhunt_pro/routes/app_route.dart';
import 'package:jobhunt_pro/theme/themes.dart';

import 'features/applicant/features/home/views/page_navigator.dart';
import 'features/authentication/controller/auth_controller.dart';
import 'features/authentication/screens/signup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final light = AppTheme.light();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobFinder-Pro',
      theme: light,
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                if (user.name == 'applicant') {
                  ref
                      .watch(authControllerProvider.notifier)
                      .applicantProfile(id: user.$id)
                      .then((value) => ref
                          .watch(applicantStateProvider.notifier)
                          .update((state) => value));
                } else {
                  ref
                      .watch(authControllerProvider.notifier)
                      .recruiterProfile(id: user.$id)
                      .then((value) => ref
                          .watch(recruiterStateProvider.notifier)
                          .update((state) => value));
                }
                return switch (user.name) {
                  'applicant' => const ApplicantPageNavigator(),
                  'recruiter' => const RecruiterPageNavigator(),
                  _ => const LoginView(),
                };
              }
              return const SignupView();
            },
            error: (error, st) => Text(error.toString()),
            loading: () => const Scaffold(
                body: Center(child: CircularProgressIndicator())),
          ),
      onGenerateRoute: AppRoute.generatedRoute,
    );
  }
}
