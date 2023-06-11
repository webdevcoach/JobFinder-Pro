
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/features/applicant/features/bookmarks/widgets/saved_job_card.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';

import '../../../../common/custom_appbar.dart';

class SavedJobsScreen extends ConsumerWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicant = ref.watch(applicantStateProvider)!;
    return Scaffold(
      appBar: CustomAppBar(title: 'Saved', showSuffixIcon: false),
      body: 
            ListView.builder(
                itemCount: applicant.savedJobs.length,
                itemBuilder: (context, index) {
                  final saved = applicant.savedJobs.reversed.toList()[index];
                  return SavedJobCard(
                    jobId: saved,
                    imageUrl:
                        'https://pbs.twimg.com/profile_images/1658476926590414848/uqMIb2yx_400x400.jpg',
                    isBookmarked: true,
                  );
                })
        
         
    
    );
  }
}
