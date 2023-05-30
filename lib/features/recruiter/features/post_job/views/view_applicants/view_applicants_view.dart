import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ViewApplicantsView extends StatelessWidget {
  final List<String> applicantId;
  const ViewApplicantsView({super.key, required this.applicantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Applicants')),
      body: const Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=60'),
            ),
            title: Text('Brian Griffin'),
            trailing: Icon(IconlyLight.arrow_right_2),
          )
        ],
      ),
    );
  }
}
