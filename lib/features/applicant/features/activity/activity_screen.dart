import 'package:flutter/material.dart';

import '../../../../common/custom_appbar.dart';
import '../../../../common/searchbox.dart';
import '../../../../common/selectable_buttons.dart';
import 'components/activity_card.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Activity', showSuffixIcon: false),
      body: ListView(children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              SearchBox(showFilterButton: false, isHome: false),
              SizedBox(height: 20),
              // SelectableButtons(
              //     buttonList: activityScreenSelectableButtonText,
              //     selectedIndex: 0),
            ],
          ),
        ),
        // ListView.builder(
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   itemCount: jobsData.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return ActivityCard(
        //       id: jobsData[index].id,
        //       type: jobsData[index].type,
        //       title: jobsData[index].title,
        //       salary: jobsData[index].salary,
        //       company: jobsData[index].company,
        //       location: jobsData[index].location,
        //       imageUrl: jobsData[index].imageUrl,
        //       imageBackground: jobsData[index].imageBackground,
        //     );
        //   },
        // ),
      ]),
    );
  }
}
