import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';

class RecruiterProfileScreen extends ConsumerWidget {
  const RecruiterProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () {
                ref.watch(authControllerProvider.notifier).logout(context);
              },
              child: const Text('logout'))),
    );
  }
}
