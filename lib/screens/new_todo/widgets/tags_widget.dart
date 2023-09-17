import 'dart:async';

import 'package:animations/animations.dart';
import 'package:codelandia_to_do_riverpod/constant/sized_box.dart';
import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:codelandia_to_do_riverpod/providers/tags_list.dart';
import 'package:codelandia_to_do_riverpod/screens/tags_adding_screen/tags_adding_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/colors.dart';

class TagsWidget extends ConsumerStatefulWidget {
  final TodoModel? todoModel;
  const TagsWidget({
    super.key,
    required this.todoModel,
  });

  @override
  ConsumerState<TagsWidget> createState() => _TagsWidgetState();
}

class _TagsWidgetState extends ConsumerState<TagsWidget> {
  void initActiveTags() {
    if (widget.todoModel != null) {
      for (var element in widget.todoModel!.tags) {
        ref.watch(tagsListProvider).forEach(
          (e) {
            if (e.tagName == element.tagName) {
              ref
                  .watch(
                      tagsListProvider)[ref.watch(tagsListProvider).indexOf(e)]
                  .isAdded = true;
            }
          },
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration.zero, () => initActiveTags());
  }

  @override
  Widget build(BuildContext context) {
    var tagListProvider = ref.watch(tagsListProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Tags'.tr(context: context),
            style: const TextStyle(
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
                    setState(
                      () {
                        ref.watch(tagsListProvider).forEach(
                          (e) {
                            if (e.tagName == element.tagName) {
                              e.isAdded = value;
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              kSizedBoxW10,
              OpenContainer(
                closedElevation: 0,
                closedColor: Colors.white,
                closedShape: const CircleBorder(),
                transitionDuration: const Duration(milliseconds: 500),
                closedBuilder: (context, action) => Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                ),
                openBuilder: (context, action) => const TagsAddingScreen(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
