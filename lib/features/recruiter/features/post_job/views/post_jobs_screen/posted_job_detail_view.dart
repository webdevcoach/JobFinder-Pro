// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';

import '../../../../../../theme/colors.dart';
import '../view_applicants/view_applicants_view.dart';
import 'widgets/photo_pile.dart';

class PostedJobDetailView extends StatelessWidget {
  static const routeName = 'posted-job-detail-view';
  const PostedJobDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context)
        .textTheme
        .displayMedium!
        .copyWith(fontWeight: FontWeight.normal);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(IconlyBold.edit))
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Software Engineer',
              style:
                  txtStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Full-Time',
              style: txtStyle.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 30),
            const DividerWithSpaces(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(children: [
                Row(
                  children: [
                    IconWithText(
                      icon: 'assets/svg/category_icons/bezier.svg',
                      text: 'Applicants',
                    ),
                    Spacer(),
                    PhotoPile(
                      images: [
                        'https://i.pravatar.cc/300?img=11',
                        'https://i.pravatar.cc/300?img=22',
                        'https://i.pravatar.cc/300?img=33',
                        'https://i.pravatar.cc/300?img=4',
                        'https://i.pravatar.cc/300?img=5',
                        'https://i.pravatar.cc/300?img=6',
                        'https://i.pravatar.cc/300?img=7',
                        'https://i.pravatar.cc/300?img=1',
                        'https://i.pravatar.cc/300?img=2',
                        'https://i.pravatar.cc/300?img=3',
                        'https://i.pravatar.cc/300?img=4',
                        'https://i.pravatar.cc/300?img=5',
                        'https://i.pravatar.cc/300?img=6',
                        'https://i.pravatar.cc/300?img=7',
                      ],
                      avatarSize: 30,
                      overlapDistance: 15,
                    )
                  ],
                ),
                DividerWithSpaces(),
                Row(
                  children: [
                    IconWithText(
                      icon: 'assets/svg/recruiter_icons/people.svg',
                      text: 'Audience Reached',
                    ),
                    Spacer(),
                    Text('100k')
                  ],
                ),
                DividerWithSpaces(),
                Row(
                  children: [
                    IconWithText(
                      icon: 'assets/svg/recruiter_icons/calendar-edit.svg',
                      text: 'Posted',
                    ),
                    Spacer(),
                    Text('29th May, 2023')
                  ],
                ),
                DividerWithSpaces(),
                Row(
                  children: [
                    IconWithText(
                      icon: 'assets/svg/recruiter_icons/calendar-tick.svg',
                      text: 'Deadline',
                    ),
                    Spacer(),
                    Text('29th June, 2023')
                  ],
                ),
              ]),
            ),
            const DividerWithSpaces(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(ViewApplicantsView.routeName),
            child: Text(
              'View All Applicants',
              style: txtStyle.copyWith(color: AppColors.greyColor),
            )),
      ),
    );
  }
}

class DividerWithSpaces extends StatelessWidget {
  const DividerWithSpaces({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(color: Colors.grey),
    );
  }
}

class IconWithText extends StatelessWidget {
  final String icon;
  final String text;
  const IconWithText({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          color: AppColors.primaryColor,
          height: 20,
          width: 20,
        ),
        const SizedBox(width: 15),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
