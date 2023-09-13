import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constant/sized_box.dart';
import '../../../generated/assets.dart';

class EmptyListImage extends StatelessWidget {
  final String title;
  final String image;

  const EmptyListImage({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.1,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Center(
              child: SvgPicture.asset(
                image,
                semanticsLabel: 'Empty List',
              ),
            ),
          ),
          kSizedBoxH20,
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
