import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/apis/auth_api.dart';

class ApplicantHomeView extends ConsumerWidget {
  const ApplicantHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () {
                ref.watch(authApiProvider).logOut();
              },
              child: const Text('Logout'))),
    );
  }
}
