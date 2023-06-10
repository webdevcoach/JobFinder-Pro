import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/common/custom_forms_kit.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/views/view_applicants/apllicant_details.dart';
import 'package:jobhunt_pro/theme/colors.dart';

import '../../../../../common/info_chip.dart';
import '../../../../../common/verticalbar_decoration.dart';
import '../../../../applicant/features/apply_job/controller/apply_job_conntroller.dart';

class RecruiterHomeView extends ConsumerWidget {
  const RecruiterHomeView({super.key});

  @override
  Widget build(BuildContext context, ref) {
 final  currentUser =  ref.watch(recruiterStateProvider);
   // final currentUser = ref.watch(currentRecruiterDetailsProvider).value;

    if (currentUser == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              // const SizedBox(width: 10),
              const Text('Hi there 👋🏽'),
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
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            VerticalBar(title: 'Trending'),
            ref.watch(applicantListProvider).when(
                data: (applicant) {
                  return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: applicant.length,
                      itemBuilder: (context, index) {
                        final details = applicant[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ApplicantDetails(applicant: details)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: AppColors.secondaryColor,
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 1)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      details.profilePicture.isEmpty
                                          ? 'https://i.pravatar.cc/300?img=60'
                                          : details.profilePicture,
                                    ),
                                  ),
                                  title: CustomText(
                                      text: details.name, bold: true, size: 17),
                                  subtitle:
                                      CustomText(text: details.title, size: 14),
                                  trailing:
                                      const Icon(IconlyLight.arrow_right_2),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Wrap(
                                    spacing: 10.0,
                                    runSpacing: 10,
                                    children: details.skills
                                        .map((item) => InfoChip(
                                              title: '#$item',
                                              titleColor: Colors.blue.shade900,
                                              bold: false,
                                            ))
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 10)
                              ],
                            ),
                          ),
                        );
                      });
                },
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )),
          ],
        ));
  }
}
