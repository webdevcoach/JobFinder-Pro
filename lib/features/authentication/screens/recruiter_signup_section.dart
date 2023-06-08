import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/core/resuables/pick_file.dart';

import '../../../common/custom_forms_kit.dart';
import '../controller/auth_controller.dart';
import '../widgets/custom_auth_field.dart';

class RecruiterSignupSection extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const RecruiterSignupSection(),
      );
  const RecruiterSignupSection({super.key});

  @override
  ConsumerState<RecruiterSignupSection> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<RecruiterSignupSection> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final companyNameController = TextEditingController();
  final websiteLinkController = TextEditingController();
  final twitterController = TextEditingController();
  final linkedinController = TextEditingController();
  final facebookController = TextEditingController();

  late File image;
  bool picked = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    companyNameController.dispose();
    websiteLinkController.dispose();
    twitterController.dispose();
    linkedinController.dispose();
    facebookController.dispose();
  }

  Future<void> pickImage1() async {
    image = await PickFile.pickImage();
    setState(() {
      picked = true;
    });
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).recruiterSignUp(
          email: emailController.text,
          password: passwordController.text,
          context: context,
          companyName: companyNameController.text,
          websiteLink: websiteLinkController.text,
          twitter: twitterController.text,
          linkedIn: linkedinController.text,
          facebook: facebookController.text,
          about: 'about',
          file: image,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => pickImage1(),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: picked ? FileImage(image) : null,
                child: !picked
                    ? const Icon(
                        Icons.upload,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomAuthField(
              controller: emailController,
              hintText: 'Email',
            ),
            CustomAuthField(
              controller: passwordController,
              hintText: 'Password',
              isPasswordField: true,
            ),
            CustomAuthField(
              controller: companyNameController,
              hintText: 'Company Name',
            ),
            CustomAuthField(
              controller: websiteLinkController,
              hintText: 'Website',
            ),
            CustomAuthField(
              controller: twitterController,
              hintText: 'Twitter',
            ),
            CustomAuthField(
              controller: linkedinController,
              hintText: 'Linkedin',
            ),
            CustomAuthField(
              controller: facebookController,
              hintText: 'Facebook',
            ),
            // const SizedBox(height: 40),
            ElevatedButton(
              onPressed: onSignUp,
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const CustomText(text: 'Submit', color: Colors.white),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
