// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/features/applicant/features/apply_job/controller/apply_job_conntroller.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';
import 'package:jobhunt_pro/model/post_job.dart';

import '../../../../../common/company_logo.dart';
import '../../../../../common/svg_icon_mini.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class RecentJobCard extends ConsumerStatefulWidget {
  final PostJob job;

  final String imageUrl;
  final Color imageBackground;
  final bool isSaved;

  final void Function()? onTap;

  const RecentJobCard({
    Key? key,
    required this.imageUrl,
    required this.imageBackground,
    required this.isSaved,
    required this.job,
    this.onTap,
  }) : super(key: key);

  @override
  ConsumerState<RecentJobCard> createState() => _RecentJobCardState();
}

class _RecentJobCardState extends ConsumerState<RecentJobCard> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayMedium!;
    return InkWell(
        onTap: widget.onTap,
        child: Row(
          children: [
            CompanyLogo(
              size: 30,
              imageUrl: widget.imageUrl,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.job.jobTitle,
                          style: textStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const SvgIconMini(svg: 'location'),
                      Text(
                        ' ${widget.job.location}',
                        style: textStyle.copyWith(fontSize: 11),
                      ),
                      const SizedBox(width: 10),
                      const SvgIconMini(svg: 'briefcase'),
                      Text(
                        ' ${widget.job.jobType}',
                        style: textStyle.copyWith(fontSize: 11),
                      )
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                ref.watch(currentApplicantDetailsProvider).when(
                    data: (applicant) {
                      return InkWell(
                        onTap: () {
                          ref
                              .watch(applyJobControllerProvider.notifier)
                              .saveJob(
                                  applicant: applicant,
                                  jobId: widget.job.jobId);
                          setState(() {});
                        },
                        child: Icon(
                          applicant.savedJobs.contains(widget.job.jobId)
                              ? IconlyBold.bookmark
                              : IconlyLight.bookmark,
                          color: Colors.grey[700],
                        ),
                      );
                    },
                    error: (error, stack) => const SizedBox(),
                    loading: () => const SizedBox()),
                const SizedBox(height: 10),
                Text(timeAgo.format(widget.job.time, locale: 'en_short'))
              ],
            )
          ],
        ));
  }
}


// class RecentJobCard extends StatelessWidget {
//   final int id;
//   final String imageUrl;
//   final Color imageBackground;
//   final String title;
//   final String location;
//   final bool isSaved;
//   final JobType type;

//   const RecentJobCard({
//     Key? key,
//     required this.id,
//     required this.imageUrl,
//     required this.imageBackground,
//     required this.title,
//     required this.location,
//     required this.isSaved,
//     required this.type,
//   }) : super(key: key);

//   void selectJob(BuildContext context) {
//     Navigator.of(context).pushNamed(
//       JobDetailScreen.routeName,
//       arguments: id,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final textStyle = Theme.of(context).textTheme.headline2!;
//     return InkWell(
//       onTap: (() => selectJob(context)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
              // CompanyLogo(
              //   imageBackground: imageBackground,
              //   size: 40,
              //   imageUrl: imageUrl,
              // ),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
                  // Text(
                  //   title,
                  //   style: textStyle.copyWith(
                  //       fontSize: 18, fontWeight: FontWeight.bold),
                  //   overflow: TextOverflow.ellipsis,
                  // ),
//                   const SizedBox(height: 13),
                  // Row(
                  //   children: [
                  //     const SvgIconMini(svg: 'location'),
                  //     Text(
                  //       ' $location',
                  //       style: textStyle.copyWith(fontSize: 13),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     const SvgIconMini(svg: 'briefcase'),
                  //     Text(
                  //       ' ${type.text}',
                  //       style: textStyle.copyWith(fontSize: 13),
                  //     )
                  //   ],
                  // )
//                 ],
//               ),

//             ],
//           ),
          // Column(
          //   children: [
          //     Icon(
          //       isSaved ? IconlyBold.bookmark : IconlyLight.bookmark,
          //       color: Colors.grey[700],
          //     ),
          //     const SizedBox(height: 10),
          //     Text('${(Random().nextInt(10) + 1).toString()}h')
          //   ],
          // )
      //   ],
      // ),
//     );
//   }
// }
