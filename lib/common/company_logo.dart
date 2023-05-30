import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompanyLogo extends StatelessWidget {
  final String imageUrl;
  final double size;
  const CompanyLogo({
    Key? key,
    required this.imageUrl,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size + 10,
      width: size + 10,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SvgPicture.network(
        imageUrl,
        height: size,
        width: size,
        color: Colors.white,
      ),
    );
  }
}
