// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/core/extensions/sentence_splitter.dart';
import 'package:jobhunt_pro/features/recruiter/features/post_job/controller/post_job_controller.dart';

import '../../../../../../theme/colors.dart';

enum WorkType {
  fullTime('Full-Time'),
  partTime('Part-Time'),
  contract('Contract');

  const WorkType(this.text);
  final String text;
}

enum WorkMode {
  remote('Remote'),
  onSite('On-Site'),
  hybrid('Hybrid');

  const WorkMode(this.text);
  final String text;
}

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
  WorkMode _seletectedWorkMode = WorkMode.onSite;
  List<String> perksAndBenefits = [];
  DateTime deadline = DateTime.now();

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
          }
        });
      },
      child: Chip(
        label: Text(chipName),
        backgroundColor:
            isSelected ? AppColors.primaryColor.withOpacity(0.5) : null,
      ),
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
                    const CustomTextBold(text: 'Work Type'),
                    RadioListTile<WorkType>(
                      contentPadding: const EdgeInsets.all(5),
                      title: CustomText(text: WorkType.fullTime.text),
                      value: WorkType.fullTime,
                      groupValue: _seletectedWorkType,
                      onChanged: (WorkType? value) {
                        setState(() {
                          _seletectedWorkType = value!;
                        });
                      },
                    ),
                    RadioListTile<WorkType>(
                      contentPadding: const EdgeInsets.all(5),
                      title: CustomText(text: WorkType.partTime.text),
                      value: WorkType.partTime,
                      groupValue: _seletectedWorkType,
                      onChanged: (WorkType? value) {
                        setState(() {
                          _seletectedWorkType = value!;
                        });
                      },
                    ),
                    RadioListTile<WorkType>(
                      contentPadding: const EdgeInsets.all(5),
                      title: CustomText(text: WorkType.contract.text),
                      value: WorkType.contract,
                      groupValue: _seletectedWorkType,
                      onChanged: (WorkType? value) {
                        setState(() {
                          _seletectedWorkType = value!;
                        });
                      },
                    ),
                    const CustomTextBold(text: 'Work Mode'),
                    RadioListTile<WorkMode>(
                      contentPadding: const EdgeInsets.all(5),
                      title: CustomText(text: WorkMode.onSite.text),
                      value: WorkMode.onSite,
                      groupValue: _seletectedWorkMode,
                      onChanged: (WorkMode? value) {
                        setState(() {
                          _seletectedWorkMode = value!;
                        });
                      },
                    ),
                    RadioListTile<WorkMode>(
                      contentPadding: const EdgeInsets.all(5),
                      title: CustomText(text: WorkMode.remote.text),
                      value: WorkMode.remote,
                      groupValue: _seletectedWorkMode,
                      onChanged: (WorkMode? value) {
                        setState(() {
                          _seletectedWorkMode = value!;
                        });
                      },
                    ),
                    RadioListTile<WorkMode>(
                      contentPadding: const EdgeInsets.all(5),
                      title: CustomText(text: WorkMode.hybrid.text),
                      value: WorkMode.hybrid,
                      groupValue: _seletectedWorkMode,
                      onChanged: (WorkMode? value) {
                        setState(() {
                          _seletectedWorkMode = value!;
                        });
                      },
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
                    TextButton(
                        onPressed: () async {
                          final DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: deadline,
                              firstDate: DateTime(2023, 1),
                              lastDate: DateTime(2050));
                          if (date != null) {
                            setState(() {
                              deadline = date;
                            });
                          }
                        },
                        child: Text('Deadline: ${deadline.toString()}')),
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

class CustomTextBold extends StatelessWidget {
  final String text;
  const CustomTextBold({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme.displayMedium;

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(text,
          style: txtStyle!.copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  const CustomText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme.displayMedium;

    return Text(text, style: txtStyle!.copyWith(fontSize: 15));
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool enableMaxlines;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.enableMaxlines = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: enableMaxlines ? 5 : 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade300.withOpacity(0.1),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        //hintText: 'hintText',
        hintStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
