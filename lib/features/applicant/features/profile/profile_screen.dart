// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/common/custom_forms_kit.dart';
import 'package:jobhunt_pro/common/svg_icon_mini.dart';
import 'package:jobhunt_pro/constants/app_svg.dart';
import 'package:jobhunt_pro/core/resuables/date_format.dart';
import 'package:jobhunt_pro/features/applicant/features/profile/widgets/profile_info_box.dart';
import 'package:jobhunt_pro/routes/app_route.dart';
import '../../../../apis/auth_api.dart';
import '../../../../common/info_chip.dart';
import '../../../../theme/colors.dart';
import '../../../authentication/controller/auth_controller.dart';
import 'widgets/infobox.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final applicant = ref.watch(currentApplicantDetailsProvider).value;
    final applicantAccount = ref.watch(currentUserAccountProvider).value;

    final textStyle = Theme.of(context).textTheme.displayMedium;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Profile'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(IconlyBold.setting)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.editApplicantProfile,
                    arguments: applicant);
              },
              icon: const Icon(IconlyBold.edit))
        ],
      ),
      body: SingleChildScrollView(
        child: 
               Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          ref.watch(authApiProvider).logout();
                        },
                        child: const Text('Logout'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(applicant!.profilePicture),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(applicant.name,
                                  style: textStyle!.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Text(applicant.title,
                                  style: textStyle.copyWith(fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InfoBox(
                              text: applicant.appliedJobs.length.toString(),
                              subtext: 'Applied'),
                          InfoBox(
                              text: formatDate(DateTime.parse(
                                  applicantAccount!.registration)),
                              subtext: 'Member Since'),
                          const InfoBox(text: '19', subtext: 'Offers'),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 15),
                      ProfileInfoBox(
                        title: 'Contact Information',
                        icon: AppSvg.userBold,
                        children: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SvgIconMini(svg: AppSvg.locationLight),
                                  const SizedBox(width: 5),
                                  CustomText(text: applicant.location, size: 14),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const SvgIconMini(svg: AppSvg.mailLight),
                                  const SizedBox(width: 5),
                                  CustomText(text: applicant.email, size: 14),
                                ],
                              ),
                            ]),
                      ),
                      ProfileInfoBox(
                        title: 'Summary',
                        icon: AppSvg.documentTextBold,
                        children: CustomText(text: applicant.about, size: 14),
                      ),
                      ProfileInfoBox(
                        title: 'Skills',
                        icon: AppSvg.awardBold,
                        children: Wrap(
                          spacing: 8.0,
                          runSpacing: 10,
                          children: applicant.skills
                              .map((item) => InfoChip(
                                    title: item,
                                    titleColor: AppColors.primaryColor,
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ]),
              )
            
           
      ),
    );
  }
}
