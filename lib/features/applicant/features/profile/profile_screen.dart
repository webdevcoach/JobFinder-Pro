// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/apis/auth_api.dart';

import '../../../../common/custom_appbar.dart';
import '../../../../common/verticalbar_decoration.dart';
import '../../../../constants/app_svg.dart';
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

    final textStyle = Theme.of(context).textTheme.displayMedium;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'Profile',
        suffixIcon: IconlyBold.edit,
        editProfile: true,
        onProfileEdit: () {},
      ),
      body: SingleChildScrollView(
        child: ref.watch(currentApplicantDetailsProvider).when(
            data: (profile) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          ref.watch(authApiProvider).logout();
                        },
                        child: const Text('Logout'),
                      ),
                      CircleAvatar(
                        radius: 80,
                        child: ClipOval(
                            child: Image.asset('assets/images/abraham.jpg')),
                      ),
                      Text(profile.name,
                          style: textStyle!.copyWith(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Mobile Engineer',
                              style: textStyle.copyWith(fontSize: 15)),
                          SvgPicture.asset(AppSvg.verifyBold,
                              color: AppColors.primaryColor),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InfoBox(
                              text: profile.appliedJobs.length.toString(),
                              subtext: 'Applied'),
                          const InfoBox(text: '12', subtext: 'Reviewed'),
                          const InfoBox(text: '19', subtext: 'Interviews'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      VerticalBar(
                        title: 'About Me',
                        trailing: '',
                      ),
                      // Text(
                      //   loremText.substring(0, 180),
                      //   textAlign: TextAlign.left,
                      // ),
                      const SizedBox(height: 20),

                      const SizedBox(height: 20),
                      // const EmploymentTile(
                      //   role: 'Staff Engineer - Google',
                      //   period: 'April, 2022 - Present',
                      // ),
                      // const EmploymentTile(
                      //   role: 'Senior Engineer - Yahoo',
                      //   period: 'April, 2017 - April, 2022',
                      // ),
                      // const EmploymentTile(
                      //   role: 'Data Scientist Engineer - IBM',
                      //   period: 'Apirl, 2008 - June, 2017',
                      // ),
                    ]),
              );
            },
            error: (error, stackTrace) => const Center(
                  child: SizedBox(),
                ),
            loading: () => const SizedBox.shrink()),
      ),
    );
  }
}
