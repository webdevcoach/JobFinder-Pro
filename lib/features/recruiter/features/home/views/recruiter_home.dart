import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';

import '../../../../applicant/features/apply_job/controller/apply_job_conntroller.dart';

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
                'Hi there 👋🏽 ${currentUser!.companyName}',
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
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ref.watch(applicantListProvider).when(
                    data: (applicant) {
                      return ListView.builder(
                          itemCount: applicant.length,
                          itemBuilder: (context, index) {
                            final details = applicant[index];
                            // design for applicant card
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  details.profilePicture ??
                                      'https://i.pravatar.cc/300?img=60',
                                ),
                              ),
                              title: Text(details.name),
                              onTap: () {},
                              trailing: const Icon(IconlyLight.arrow_right_2),
                            );
                          });
                    },
                    error: (error, stackTrace) =>
                        Center(child: Text(error.toString())),
                    loading: () => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )),
              ));
  }
}
