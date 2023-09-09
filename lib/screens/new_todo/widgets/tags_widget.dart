import 'package:codelandia_to_do_riverpod/constant/sized_box.dart';
import 'package:codelandia_to_do_riverpod/providers/tags_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/colors.dart';

class TagsWidget extends ConsumerStatefulWidget {
  const TagsWidget({
    super.key,
  });

  @override
  ConsumerState<TagsWidget> createState() => _TagsWidgetState();
}

class _TagsWidgetState extends ConsumerState<TagsWidget> {
  @override
  Widget build(BuildContext context) {
    var tagListProvider = ref.watch(tagsListProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Tags',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 6,
            children: [
              for (var element in tagListProvider)
                ChoiceChip(
                  label: Text(element.tagName),
                  selected: element.isAdded,
                  selectedColor:
                      kColorList[tagListProvider.indexOf(element) % 12],
                  onSelected: (value) {
                    setState(() {
                      ref.watch(tagsListProvider).forEach((e) {
                        if (e == element) {
                          e.isAdded = value;
                        }
                      });
                    });
                  },
                ),
              kSizedBoxW10,
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
