// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/common/route_transition.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/controller/post_job_controller.dart';
import 'package:jobhunt_pro/routes/app_route.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../../applicant/features/job_detail/job_detail_screen.dart';
import 'photo_pile.dart';

class JobCard extends ConsumerWidget {
  final bool isApplicant;
  final String postedJobsId;
  final void Function()? onTap;
  const JobCard({
    Key? key,
    required this.isApplicant,
    this.onTap,
    required this.postedJobsId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme.displayMedium!;

    // void selectJob(BuildContext context) {
    //   Navigator.of(context)
    //       .pushNamed(AppRoute.postedJobDetailsView, arguments: job);
    // }

    return ref.watch(myPostedJobProvider(postedJobsId)).when(
        data: (job) {
          return GestureDetector(
              onTap: () => isApplicant
                  ? Navigator.of(context).push(
                      pageRouteTransition(JobDetailScreen(jobId: job.jobId)))
                  : Navigator.of(context)
                      .pushNamed(AppRoute.postedJobDetailsView, arguments: job),
              child: Container(
                  decoration: BoxDecoration(
                      // color: AppColors.greyColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      job.jobTitle,
                                      style: textStyle.copyWith(
                                          color: Colors.grey.shade800,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(timeago.format(job.time),
                                  style: textStyle.copyWith(
                                      fontSize: 11, color: Colors.grey))
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.more_vert,
                              color: Colors.grey[700],
                            ),
                            const SizedBox(height: 3),
                            const PhotoPile(
                              images: [
                                'https://i.pravatar.cc/300?img=1',
                                'https://i.pravatar.cc/300?img=2',
                                'https://i.pravatar.cc/300?img=3',
                                'https://i.pravatar.cc/300?img=4',
                                'https://i.pravatar.cc/300?img=5',
                                'https://i.pravatar.cc/300?img=6',
                                'https://i.pravatar.cc/300?img=7',
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )));
        },
        error: (error, stackTrace) => const Center(),
        loading: () => const SizedBox());
  }
}
