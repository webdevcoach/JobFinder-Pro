import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';

import 'features/post_job/controller/post_job_controller.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TestFeature(),
    );
  }
}

class TestFeature extends ConsumerWidget {
  const TestFeature({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('TESTING THIS'),
      ),
      body: Center(
        child: ref.watch(currentEmployeeDetailsProvider).when(
            data: (user) {
              return Text(user.name);
            },
            error: (e, t) => Text(e.toString()),
            loading: () => const Text('Loading')),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          ref.watch(postJobControllerProvider.notifier).postJob(jobTitle: 'jobTitle');
          // ref.watch(authControllerProvider.notifier).login(
          //       email: 'desmond@gmail.com',
          //       password: '12345678',
          //       context: context,
          //     );

          // .employerSignUp(
          //       companyName: 'Intelli Kode',
          //       websiteLink: 'ww.hello.com',
          //       email: 'hello@gmail.com',
          //       twitter: 'https://twitter.com/home',
          //       linkedIn: 'https://twitter.com/home',
          //       facebook: 'https://twitter.com/home',
          //       about: 'We are indie hackers',
          //       password: '123456789',
          //       context: context
          //     );

          // .employeeSignUp(
          //     name: 'Desmond',
          //     email: 'desmond@gmail.com',
          //     password: '12345678',
          //     context: context,
          //     );
        },
        child: const Icon(Icons.foggy),
      ),
    );
  }
}
