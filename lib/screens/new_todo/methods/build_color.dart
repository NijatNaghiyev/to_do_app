import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/colors.dart';
import '../../../providers/selected_color.dart';

Column buildColor(WidgetRef ref, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          'Color',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Wrap(
          children: [
            for (var element in kColorList)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    ref
                        .read(selectedColor.notifier)
                        .update((state) => state = element);
                    color = element;
                  },
                  child: CircleAvatar(
                    backgroundColor: element,
                    radius: 22,
                    child: kColorList.indexOf(ref.watch(selectedColor)) ==
                            kColorList.indexOf(element)
                        ? const Icon(Icons.check)
                        : null,
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}
