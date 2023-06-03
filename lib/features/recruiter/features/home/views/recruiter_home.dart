import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/common/custom_forms_kit.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/views/view_applicants/apllicant_details.dart';
import 'package:jobhunt_pro/theme/colors.dart';

import '../../../../applicant/features/apply_job/controller/apply_job_conntroller.dart';

class RecruiterHomeView extends ConsumerWidget {
  const RecruiterHomeView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final txtStyle = Theme.of(context).textTheme.displayMedium;

    final currentUser = ref.watch(currentRecruiterDetailsProvider).value;

    if (currentUser == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const CircleAvatar(
                radius: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'Hi there 👋🏽 ${currentUser.companyName}',
                style: txtStyle!.copyWith(fontSize: 13),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Badge(
                    label: Text('5'),
                    child: Icon(
                      IconlyLight.notification,
                      color: Colors.grey,
                    ),
                  ))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: ref.watch(applicantListProvider).when(
              data: (applicant) {
                return ListView.builder(
                    itemCount: applicant.length,
                    itemBuilder: (context, index) {
                      final details = applicant[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            details.profilePicture.isEmpty
                                ? 'https://i.pravatar.cc/300?img=60'
                                : details.profilePicture,
                          ),
                        ),
                        title: CustomText(
                            text: details.name, bold: true, size: 17),
                        subtitle: CustomText(
                            text: details.title,
                            size: 14,
                            color: AppColors.primaryColor),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ApplicantDetails(applicant: details)));
                        },
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
