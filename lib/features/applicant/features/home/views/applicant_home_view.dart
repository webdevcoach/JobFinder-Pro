// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobhunt_pro/common/route_transition.dart';
import 'package:jobhunt_pro/features/applicant/features/job_detail/job_detail_screen.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/controller/post_job_controller.dart';

import '../../../../../common/searchbox.dart';
import '../../../../../common/verticalbar_decoration.dart';
import '../../../../../constants/category_data.dart';
import '../../../../../model/post_job.dart';
import '../../../../../theme/colors.dart';
import '../widgets/category_icon.dart';
import '../widgets/recent_job_card.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  List<PostJob> recentsJobs = [];

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayLarge;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning 👋🏽',
                  // style: txtStyle!.copyWith(fontSize: 13),
                ),
                SizedBox(height: 2),
                Text(
                  'dd',
                  // style: txtStyle.copyWith(
                  //     fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.notification,
                  // color: Colors.grey,
                ))
          ],
        ),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SearchBox(),
              const SizedBox(height: 10),
              VerticalBar(title: 'Tips for you'),
              const SizedBox(height: 10),
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How to create a\nperfect cv for you',
                          style: textStyle!
                              .copyWith(fontSize: 16, color: Colors.grey[50]),
                        ),
                        const SizedBox(height: 10),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          onPressed: () {},
                          color: Colors.white,
                          child: Text(
                            'Details',
                            style: textStyle.copyWith(
                                fontSize: 17,
                                color: AppColors.primaryColor.withOpacity(0.8)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: -2,
                    right: 24,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor.withOpacity(0.5),
                      radius: 70,
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    right: 0,
                    // alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'assets/images/image2.png',
                      width: 180,
                      height: 200,
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 20),
              VerticalBar(title: 'Category'),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryIcons(
                      iconColor: categoryData[index].iconColor,
                      title: categoryData[index].category,
                      icon: categoryData[index].icon,
                    );
                  },
                ),
              ),
              VerticalBar(title: 'Recent Jobs'),
              const SizedBox(height: 5),

              ref.watch(postedJobProvider).when(
                    data: (data) {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return data[index].isOpened
                              ? RecentJobCard(
                                  onTap: () => Navigator.of(context).push(
                                      pageRouteTransition(JobDetailScreen(
                                          jobId: data[index].jobId))),
                                  id: data[index].jobId,
                                  type: data[index].jobType,
                                  title: data[index].jobTitle,
                                  isSaved: data[index].isOpened,
                                  location: data[index].location,
                                  imageUrl: 'https://i.pravatar.cc/300?img=1',
                                  imageBackground: Colors.transparent,
                                )
                              : const SizedBox();
                        },
                      );
                    },
                    error: (error, st) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                  ),
              // ListView.separated(
              //   physics: const NeverScrollableScrollPhysics(),
              //   separatorBuilder: (context, index) =>
              //       const SizedBox(height: 15),
              //   shrinkWrap: true,
              //   itemCount: jobsData.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return RecentJobCard(
              //       id: jobsData[index].id,
              //       type: jobsData[index].type,
              //       title: jobsData[index].title,
              //       isSaved: jobsData[index].isSaved,
              //       location: jobsData[index].location,
              //       imageUrl: jobsData[index].imageUrl,
              //       imageBackground: jobsData[index].imageBackground,
              //     );
              //   },
              // ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ]),
    );
  }
}
