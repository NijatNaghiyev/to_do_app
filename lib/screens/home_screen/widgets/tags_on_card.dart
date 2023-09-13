import 'package:codelandia_to_do_riverpod/providers/todo_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagsOnCard extends ConsumerWidget {
  final int indexCard;
  const TagsOnCard({
    required this.indexCard,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todoList = ref.watch(todoListProvider);
    return todoList[indexCard].tags.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: todoList[indexCard].tags.length,
            itemBuilder: (context, index) => OutlinedButtonTagsCard(
              tagName: todoList[indexCard].tags[index].tagName,
            ),
          )
        : const SizedBox();
  }
}

class OutlinedButtonTagsCard extends StatelessWidget {
  final String tagName;
  const OutlinedButtonTagsCard({
    super.key,
    required this.tagName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          side: MaterialStateProperty.all(
            const BorderSide(
              color: Colors.black,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: null,
        child: Text(
          tagName,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
