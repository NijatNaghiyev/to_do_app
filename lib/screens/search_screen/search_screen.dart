import 'dart:async';

import 'package:codelandia_to_do_riverpod/generated/assets.dart';
import 'package:codelandia_to_do_riverpod/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/search_filter_enum.dart';
import '../../providers/todo_list_provider.dart';
import '../home_screen/widgets/empty_list_image.dart';
import '../home_screen/widgets/to_do_card_widget.dart';
import 'methods/app_bar_search.dart';
import 'methods/filter_methods.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var selectedDropDown = ref.watch(searchFilterProvider);
    var searchList = ref.watch(searchProvider);
    var todoList = ref.watch(todoListProvider);
    return Scaffold(
      appBar: buildAppBarSearch(context, selectedDropDown, ref),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            searchList.isEmpty
                ? const EmptyListImage(
                    image: Assets.imagesSearch,
                    title: 'Search To Do',
                  )
                : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchList.length,
                      itemBuilder: (context, index) => ToDoCardWidget(
                        indexCard: todoList.indexOf(searchList[index]),
                        key: ValueKey(searchList[index].id),
                        todoModel: searchList[index],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
