// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/model/post_job.dart';
import 'package:jobhunt_pro/routes/app_route.dart';

import '../../../../../../constants/app_svg.dart';
import '../../../../../../core/resuables/date_format.dart';
import '../../../../../../theme/colors.dart';
import '../../controller/post_job_controller.dart';
import 'widgets/photo_pile.dart';

class PostedJobDetailView extends ConsumerWidget {
  final PostJob job;
  const PostedJobDetailView({super.key, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txtStyle = Theme.of(context)
        .textTheme
        .displayMedium!
        .copyWith(fontWeight: FontWeight.normal);

    final seletectedJob = ref.watch(postedJobDetailsProvider(job.jobId)).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(IconlyBold.edit))
        ],
      ),
      body: seletectedJob == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    job.jobTitle,
                    style: txtStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    job.jobType,
                    style: txtStyle.copyWith(
                        color: AppColors.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 30),
                  const DividerWithSpaces(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(children: [
                      const Row(
                        children: [
                          IconWithText(
                            icon: AppSvg.peopleLight,
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
                      const DividerWithSpaces(),
                      const Row(
                        children: [
                          IconWithText(
                            icon: AppSvg.trendUpLight,
                            text: 'Audience Reached',
                          ),
                          Spacer(),
                          Text('100k')
                        ],
                      ),
                      const DividerWithSpaces(),
                      Row(
                        children: [
                          const IconWithText(
                            icon: AppSvg.calenderEditLight,
                            text: 'Posted',
                          ),
                          const Spacer(),
                          Text(formatDate(job.time))
                        ],
                      ),
                      const DividerWithSpaces(),
                      Row(
                        children: [
                          const IconWithText(
                            icon: AppSvg.calenderTickLight,
                            text: 'Deadline',
                          ),
                          const Spacer(),
                          Text(formatDate(job.deadline))
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
            onPressed: () => Navigator.of(context).pushNamed(
                  AppRoute.viewApplicants,
                  arguments: job.applicationReceived,
                ),
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
