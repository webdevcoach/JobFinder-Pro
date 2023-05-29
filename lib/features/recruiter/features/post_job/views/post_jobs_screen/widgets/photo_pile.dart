import 'dart:math';

import 'package:flutter/material.dart';

class PhotoPile extends StatelessWidget {
  final List<String> images;
  final double avatarSize;
  final double overlapDistance;

  const PhotoPile({
    Key? key,
    required this.images,
    this.avatarSize = 20.0,
    this.overlapDistance = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int remaining = images.length > 4 ? images.length - 3 : 0;
    List<Widget> widgets = [];

    for (var i = 0; i < (images.length > 4 ? 3 : images.length); i++) {
      widgets.add(Positioned(
        left: i * overlapDistance,
        child: CircleAvatar(
          radius: avatarSize / 2,
          backgroundImage: NetworkImage(images[i]),
        ),
      ));
    }

    if (remaining > 0) {
      widgets.add(
        Positioned(
          left: 3 * overlapDistance,
          child: Container(
            width: avatarSize,
            height: avatarSize,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '+$remaining',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: avatarSize + (min(3, images.length) * overlapDistance),
      height: avatarSize,
      child: Stack(
        children: widgets,
      ),
    );
  }
}
