import 'package:codelandia_to_do_riverpod/constant/colors.dart';
import 'package:codelandia_to_do_riverpod/constant/sized_box.dart';
import 'package:codelandia_to_do_riverpod/providers/tags_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagsAddingScreen extends ConsumerWidget {
  const TagsAddingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollController scrollController = ScrollController();
    TextEditingController textEditingController = TextEditingController();
    var tagsList = ref.watch(tagsListProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Your Tags',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
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
                      controller: textEditingController,
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
                        label: const Text('Tag name'),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        hintText: 'Enter your tag',
                      ),
                      onSubmitted: (value) {
                        if (textEditingController.text.isNotEmpty) {
                          ref.read(tagsListProvider.notifier).addTag(
                                textEditingController.text.trim(),
                              );
                        }
                      },
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        ref.read(tagsListProvider.notifier).addTag(
                              textEditingController.text.trim(),
                            );
                      }
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kColorList[index % 12],
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
