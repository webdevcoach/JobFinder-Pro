import 'package:flutter/material.dart';

import 'active_jobs.dart';
import 'closed_jobs.dart';
import 'post_a_job_view.dart';

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
        actions: [
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () =>
                  Navigator.of(context).pushNamed(PostAJobView.routeName),
              child: const Text('Post A Job')),
          const SizedBox(width: 10)
        ],
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
                  padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                  // backgroundColor: MaterialStatePropertyAll(Colors.red),
                ),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () =>
      //       Navigator.of(context).pushNamed(PostAJobView.routeName),
      //   child: const Icon(Icons.add),
      // ),

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
