import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/controller/post_job_controller.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import '../../../../../common/info_chip.dart';
import '../../../../../common/svg_icon_mini.dart';
import '../../../../../constants/app_svg.dart';
import '../../../../../theme/colors.dart';

class SavedJobCard extends ConsumerWidget {
  final String jobId;
  //final int id;
  //final WorkType type;
  // final String title;
  final bool isBookmarked;
  // final String location;
  final String imageUrl;
  //final Color imageBackground;
  const SavedJobCard({
    Key? key,
    // required this.id,
    // required this.type,
    required this.jobId,
    required this.isBookmarked,
    // required this.location,
    required this.imageUrl,
    //required this.imageBackground,
  }) : super(key: key);

  // final TextStyle? textStyle;
  // void selectJob(BuildContext context) {
  //   Navigator.of(context).pushNamed(
  //     JobDetailScreen.routeName,
  //     arguments: id,
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme.displayMedium!;

    int randomIndex = Random().nextInt(3);

    List infoChipTextAndColor = [
      ['Open', Colors.green],
      ['Applied', Colors.indigo],
      ['Closed', Colors.blue]
    ];
    return ref.watch(myPostedJobProvider(jobId)).when(
        data: (job) {
          return GestureDetector(
            // onTap: (() => selectJob(context)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.shade100,
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  )),
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                      leading: Image.network(imageUrl),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Text(
                          job.jobTitle,
                          style: textStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: const Icon(IconlyBold.bookmark,
                          color: AppColors.primaryColor),
                      subtitle: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SvgIconMini(svg: AppSvg.locationLight),
                          const SizedBox(width: 5),
                          Text(
                            job.location,
                            style: textStyle.copyWith(fontSize: 13),
                          ),
                          const SizedBox(width: 10),
                          const SvgIconMini(svg: AppSvg.briefcaseLight),
                          const SizedBox(width: 5),
                          Text(
                            job.jobType,
                            style: textStyle.copyWith(fontSize: 13),
                          )
                        ],
                      )),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoChip(
                          title: infoChipTextAndColor[randomIndex][0],
                          titleColor: infoChipTextAndColor[randomIndex][1],
                        ),
                        InfoChip(
                            title: timeAgo.format(job.time),
                            titleColor: Colors.grey[800]!),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        error: (error, trace) => const SizedBox(),
        loading: () => const SizedBox());
  }
}
