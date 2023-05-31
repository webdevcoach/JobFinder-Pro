import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';

class RecruiterHomeView extends ConsumerWidget {
  const RecruiterHomeView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final txtStyle = Theme.of(context).textTheme.displayMedium;

    final currentUser = ref.watch(currentRecruiterDetailsProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
            ),
            const SizedBox(width: 10),
            Text(
              'Hi there 👋🏽',
              style: txtStyle!.copyWith(fontSize: 13),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.notification,
                  color: Colors.grey,
                ))
          ],
        ),
      ),
      body: currentUser == null
          ? const CircularProgressIndicator()
          : const SingleChildScrollView(
              child: Column(
                children: [
                  Text('Insights'),
                  Text('Recents applicants'),
                  Text('Trending Candidates'),
                ],
              ),
            ),
    );
  }
}
