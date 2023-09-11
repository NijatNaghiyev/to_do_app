import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constant/sized_box.dart';
import '../../../generated/assets.dart';

class EmptyListImage extends StatelessWidget {
  const EmptyListImage({
    super.key,
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
                Assets.imagesUndrawNoDataReKwbl,
                semanticsLabel: 'Empty List',
              ),
            ),
          ),
          kSizedBoxH20,
          const Text(
            'Your To Do List is Empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
