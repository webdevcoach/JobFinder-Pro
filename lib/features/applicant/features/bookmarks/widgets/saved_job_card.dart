import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/core/enums/enums.dart';

import '../../../../../common/company_logo.dart';
import '../../../../../common/info_chip.dart';
import '../../../../../common/svg_icon_mini.dart';
import '../../../../../theme/colors.dart';

class SavedJobCard extends StatelessWidget {
  final int id;
  final WorkType type;
  final String title;
  final bool isBookmarked;
  final String location;
  final String imageUrl;
  final Color imageBackground;
  const SavedJobCard({
    Key? key,
    required this.id,
    required this.type,
    required this.title,
    required this.isBookmarked,
    required this.location,
    required this.imageUrl,
    required this.imageBackground,
  }) : super(key: key);

  // final TextStyle? textStyle;
  // void selectJob(BuildContext context) {
  //   Navigator.of(context).pushNamed(
  //     JobDetailScreen.routeName,
  //     arguments: id,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayMedium!;

    int randomIndex = Random().nextInt(3);

    List infoChipTextAndColor = [
      ['Open', Colors.green],
      ['Applied', Colors.indigo],
      ['Closed', Colors.blue]
    ];

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
                leading: CompanyLogo(
                  imageUrl: imageUrl,
                  size: 40,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Text(
                    title,
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
                    const SvgIconMini(svg: 'location'),
                    const SizedBox(width: 5),
                    Text(
                      location,
                      style: textStyle.copyWith(fontSize: 13),
                    ),
                    const SizedBox(width: 10),
                    const SvgIconMini(svg: 'briefcase'),
                    const SizedBox(width: 5),
                    Text(
                      type.text,
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
                      title: '${Random().nextInt(10) + 1} hours ago',
                      titleColor: Colors.grey[800]!),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
