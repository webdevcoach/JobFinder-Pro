import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/core/extensions/sentence_splitter.dart';
import 'package:jobhunt_pro/features/authentication/controller/auth_controller.dart';
import 'package:jobhunt_pro/model/applicant.dart';

class EditApplicantProfile extends ConsumerWidget {
  final Applicant applicant;
  const EditApplicantProfile({super.key, required this.applicant});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(text: applicant.name);
    final aboutController = TextEditingController(text: applicant.about);
    final experienceController =
        TextEditingController(text: applicant.experience);
    final locationController = TextEditingController(text: applicant.location);
    final titleController = TextEditingController(text: applicant.title);
    final skillsController =
        TextEditingController(text: applicant.skills.toString());
    void updateProfile() {
      ref.watch(authControllerProvider.notifier).updateApplicantProfile(
            applicant: applicant.copyWith(
              name: nameController.text,
              about: aboutController.text,
              experience: experienceController.text,
              location: locationController.text,
              profilePicture: '',
              skills: skillsController.text.sentenceToList(),
              title: titleController.text,
            ),
          );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: updateProfile, child: const Text('Update'))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(applicant.name),
            TextField(
              controller: nameController,
            ),
            TextField(
              controller: aboutController,
            ),
          ],
        ),
      ),
    );
  }
}
