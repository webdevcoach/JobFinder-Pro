import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/core/resuables/pick_image.dart';

import '../controller/auth_controller.dart';
import '../widgets/auth_field.dart';

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

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Future<File?> pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final imageFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (imageFile != null) {
  //     return File(imageFile.path);
  //   }
  //   return null;
  // }

  Future<void> pickImage2() async {
     image = await PickFile.pickImage();
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

    return isLoading
        ? const CircularProgressIndicator()
        : Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomAuthField(
                    controller: emailController,
                    hintText: 'Email',
                  ),
                  CustomAuthField(
                    controller: passwordController,
                    hintText: 'Password',
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
                    child: const Text('Submit'),
                  ),
                  // ElevatedButton(
                  //     onPressed: pickImage2,
                  //     child: const Text('pickImage')),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
  }
}
