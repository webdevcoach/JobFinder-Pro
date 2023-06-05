import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/core/resuables/ui/error_and_loading.dart';
import 'package:jobhunt_pro/features/applicant/features/apply_job/controller/apply_job_conntroller.dart';
import 'package:jobhunt_pro/features/applicant/features/home/widgets/recent_job_card.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';

class JobSearch extends ConsumerStatefulWidget {
  const JobSearch({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobSearchState();
}

class _JobSearchState extends ConsumerState<JobSearch> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String keyWord = ref.watch(currentApplicantDetailsProvider).value!.title;
   
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SearchBar(
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      keyWord = value;
                    });
                  }),
              Expanded(
                  child: keyWord == null
                      ? const Center(
                          child: Text('Search Now...'),
                        )
                      : ref.watch(jobSearchProvider(keyWord)).when(
                          data: (result) {
                            return ListView.builder(
                                itemCount: result.length,
                                itemBuilder: (context, index) {
                                  return RecentJobCard(
                                      imageBackground: Colors.blue,
                                      job: result[index]);
                                });
                          },
                          error: errorWidget,
                          loading: loading))
            ],
          )),
    );
  }
}
