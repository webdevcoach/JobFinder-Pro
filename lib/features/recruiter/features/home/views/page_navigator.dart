import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../post_job/views/post_jobs_screen/jobs_screen.dart';
import '../../post_job/views/recruiter_profile/recruiter_profile_screen.dart';
import 'recruiter_home.dart';

class RecruiterPageNavigator extends StatefulWidget {
  const RecruiterPageNavigator({super.key});

  @override
  RecruiterPageNavigatorState createState() => RecruiterPageNavigatorState();
}

class RecruiterPageNavigatorState extends State<RecruiterPageNavigator> {
  int _selectedIndex = 1;

  static List<Widget> pages = [
    const RecruiterHomeView(),
    const JobsScreen(),
    const RecruiterProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.activity),
              activeIcon: Icon(IconlyBold.activity),
              label: 'Jobs',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(IconlyLight.bookmark),
            //   activeIcon: Icon(IconlyBold.bookmark),
            //   label: 'Saved',
            // ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.profile),
              activeIcon: Icon(IconlyBold.profile),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
