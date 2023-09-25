import 'package:codelandia_to_do_riverpod/constant/sized_box.dart';
import 'package:codelandia_to_do_riverpod/providers/tags_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'methods/tag_app_bar.dart';
import 'methods/to_add_tag.dart';

class TagsAddingScreen extends ConsumerStatefulWidget {
  const TagsAddingScreen({super.key});

  @override
  ConsumerState<TagsAddingScreen> createState() => _TagsAddingScreenState();
}

class _TagsAddingScreenState extends ConsumerState<TagsAddingScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    tagsEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tagsList = ref.watch(tagsListProvider);

    return Scaffold(
      appBar: buildTagAddingScreenAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: tagsEditingController,
                      decoration: InputDecoration(
                        prefixText: '#',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: Text('Tag Name'.tr(context: context)),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        hintText: 'Enter Your Tag...'.tr(context: context),
                      ),
                      onSubmitted: (value) {
                        toAddTag(ref);
                      },
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      toAddTag(ref);
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
            kSizedBoxH20,
            ListView.separated(
              controller: scrollController,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              itemCount: tagsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    tagsList[index].tagName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      ref.read(tagsListProvider.notifier).removeTag(
                            tagsList[index],
                          );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
