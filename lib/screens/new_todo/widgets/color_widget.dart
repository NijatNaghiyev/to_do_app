import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/colors.dart';
import '../../../providers/selected_color.dart';

class ColorWidget extends ConsumerStatefulWidget {
  const ColorWidget({
    super.key,
  });

  @override
  ConsumerState<ColorWidget> createState() => _ColorWidgetState();
}

class _ColorWidgetState extends ConsumerState<ColorWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colorProvider = ref.watch(selectedColor);
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
                    },
                    child: CircleAvatar(
                      backgroundColor: element,
                      radius: 22,
                      child: kColorList.indexOf(colorProvider) ==
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
}
