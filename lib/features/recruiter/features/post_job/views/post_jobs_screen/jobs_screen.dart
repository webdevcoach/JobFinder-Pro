import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobhunt_pro/routes/app_route.dart';

import '../../../../../../constants/app_svg.dart';
import '../../../../../../theme/colors.dart';
import 'active_jobs.dart';
import 'closed_jobs.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  JobsScreenState createState() => JobsScreenState();
}

class JobsScreenState extends State<JobsScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ActiveJobsView(),
    const ClosedJobsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        // actions: [
        //   MaterialButton(
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(15)),
        //       onPressed: () =>
        //           Navigator.of(context).pushNamed(AppRoute.postAJobView),
        //       child: const Text('Post A Job')),
        //   const SizedBox(width: 10)
        // ],
        title: const Text('My Jobs'),
      ),

      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SegmentedButton<int>(
                style: const ButtonStyle(
                    side: MaterialStatePropertyAll(
                        BorderSide(color: AppColors.primaryColor))),
                showSelectedIcon: false,
                selected: {_selectedIndex},
                segments: const [
                  ButtonSegment(
                    value: 0,
                    label: Text('Active'),
                    enabled: true,
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Closed'),
                    enabled: true,
                  ),
                ],
                onSelectionChanged: (newSelection) {
                  setState(() {
                    _selectedIndex = newSelection.first;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        splashColor: Colors.white,
        backgroundColor: Colors.white,
        onPressed: () => Navigator.of(context).pushNamed(AppRoute.postAJobView),
        child:
            SvgPicture.asset(AppSvg.addBroken, color: AppColors.primaryColor),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Stack(
      //   children: <Widget>[
      //     SizedBox(
      //       height: 40,
      //       width: double.infinity,
      //       child: ClipRRect(
      //         child: BackdropFilter(
      //           filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      //           child: Container(
      //             decoration: BoxDecoration(
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.grey.withOpacity(0.2),
      //                   spreadRadius: 10,
      //                   blurRadius: 40,
      //                   offset:
      //                       const Offset(0, 3), // changes position of shadow
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       height: 40,
      //       width: double.infinity,
      //       alignment: Alignment.center,
      //       child: InfoChip(title: 'title', titleColor: Colors.green.shade900),
      //     ),
      //   ],
      // ),
    );
  }
}
