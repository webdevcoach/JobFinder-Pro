// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/common/info_chip.dart';
import 'package:jobhunt_pro/core/extensions/sentence_splitter.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/controller/post_job_controller.dart';

import '../../../../../../common/custom_forms_kit.dart';
import '../../../../../../core/enums/enums.dart';
import '../../../../../../theme/colors.dart';

class PostAJobView extends ConsumerStatefulWidget {
  const PostAJobView({super.key});

  @override
  ConsumerState<PostAJobView> createState() => _PostAJobViewState();
}

class _PostAJobViewState extends ConsumerState<PostAJobView> {
  final jobTitleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final benefitsController = TextEditingController();
  final requirementController = TextEditingController();
  final salaryController = TextEditingController();
  final responsibilitiesController = TextEditingController();
  WorkType _seletectedWorkType = WorkType.fullTime;
  WorkingMode _seletectedWorkMode = WorkingMode.onSite;
  List<String> perksAndBenefits = [];
  DateTime deadline = DateTime.now().add(const Duration(days: 1));

  void _postJob() {
    ref.watch(postJobControllerProvider.notifier).postJob(
        jobTitle: jobTitleController.text,
        workingMode: _seletectedWorkMode.text,
        description: descriptionController.text,
        location: locationController.text,
        jobType: _seletectedWorkType.text,
        salary: salaryController.text,
        responsibilities: responsibilitiesController.text.sentenceToList(),
        requirement: requirementController.text.sentenceToList(),
        benefits: perksAndBenefits,
        ref: ref,
        context: context,
        deadline: deadline);
  }

  Widget _perksChips(String chipName) {
    final isSelected = perksAndBenefits.contains(chipName);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            perksAndBenefits.remove(chipName);
          } else {
            perksAndBenefits.add(chipName);
            print(chipName);
          }
        });
      },
      // child: Chip(
      //   label: Text(chipName),
      //   backgroundColor:
      //       isSelected ? AppColors.primaryColor.withOpacity(0.5) : null,
      // ),
      child: InfoChip(
          title: chipName,
          titleColor:
              isSelected ? AppColors.primaryColor : AppColors.secondaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme.displayMedium;
    final jobState = ref.watch(postJobControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post A Job'),
      ),
      body: SingleChildScrollView(
        child: jobState == JobState.loading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextBold(text: 'Title'),
                    CustomTextField(controller: jobTitleController),
                    const CustomTextBold(text: 'Description'),
                    CustomTextField(
                        controller: descriptionController,
                        enableMaxlines: true),
                    const CustomTextBold(text: 'Work Mode'),
                    for (var mode in WorkingMode.values)
                      RadioTile<WorkingMode>(
                        title: mode.text,
                        value: mode,
                        groupValue: _seletectedWorkMode,
                        onChanged: (value) =>
                            setState(() => _seletectedWorkMode = value!),
                      ),
                    const CustomTextBold(text: 'Work Type'),
                    for (var type in WorkType.values)
                      RadioTile<WorkType>(
                        title: type.text,
                        value: type,
                        groupValue: _seletectedWorkType,
                        onChanged: (value) =>
                            setState(() => _seletectedWorkType = value!),
                      ),
                    const CustomTextBold(text: 'Location'),
                    CustomTextField(controller: locationController),
                    const CustomTextBold(text: 'Salary'),
                    CustomTextField(controller: salaryController),
                    const CustomTextBold(text: 'Requirements'),
                    CustomTextField(
                        controller: requirementController,
                        enableMaxlines: true),
                    const CustomTextBold(text: 'Responsibilties'),
                    CustomTextField(
                        controller: responsibilitiesController,
                        enableMaxlines: true),
                    const CustomTextBold(text: 'Perks & Benefits'),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 10,
                      children: <Widget>[
                        _perksChips('Medical/Health Insurance'),
                        _perksChips('Paid Sick Leave'),
                        _perksChips('Performance Bonus'),
                        _perksChips('Transportation Allowance'),
                        _perksChips('Skill development'),
                        _perksChips('Equity package'),
                        _perksChips('Maternity / paternity leave'),
                        _perksChips('Paid holiday,'),
                      ],
                    ),
                    const CustomTextBold(text: 'Deadline'),
                    TextButton(
                        onPressed: () async {
                          final DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: deadline,
                              firstDate:
                                  DateTime.now().add(const Duration(days: 1)),
                              lastDate: DateTime(2050));
                          if (date != null) {
                            setState(() {
                              deadline = date;
                            });
                          }
                        },
                        child: Text('Deadline: ${deadline.toString()}')),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
        child: ElevatedButton(
            onPressed: _postJob,
            child: Text(
              'Submit',
              style: txtStyle!.copyWith(color: AppColors.greyColor),
            )),
      ),
    );
  }
}

class RadioTile<T> extends StatelessWidget {
  final String title;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const RadioTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      contentPadding: const EdgeInsets.all(5),
      title: CustomText(text: title),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
