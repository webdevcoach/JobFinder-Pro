import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../../../theme/colors.dart';
import '../posted_job_detail_view.dart';
import 'photo_pile.dart';

class JobCard extends StatelessWidget {
  final String title;
  const JobCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayMedium!;

    void selectJob(BuildContext context) {
      Navigator.of(context).pushNamed(
        PostedJobDetailView.routeName,
      );
    }

    return GestureDetector(
      onTap: () => selectJob(context),
      child: Container(
        decoration: BoxDecoration(
            // color: AppColors.greyColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.greyColor,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            title,
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
                    Text('${(Random().nextInt(10) + 1).toString()} hours ago',
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
        ),
      ),
    );
  }
}
