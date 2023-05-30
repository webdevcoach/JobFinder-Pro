import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';

class ApplicantCard extends ConsumerWidget {
  final String applicantId;
  const ApplicantCard({super.key, required this.applicantId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(applicantProfileDetailsProvider(applicantId)).when(
        data: (profile) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  profile.profilePicture ?? 'https://i.pravatar.cc/300?img=60'),
            ),
            title: Text(profile.name),
            trailing: const Icon(IconlyLight.arrow_right_2),
          );
        },
        error: (error, statckTrace) => Center(
              child: Text(error.toString()),
            ),
        loading: () => const Center());
  }
}
