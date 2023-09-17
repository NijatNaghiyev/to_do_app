import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/search_filter_enum.dart';
import '../../../providers/search_provider.dart';
import '../../../providers/todo_list_provider.dart';
import 'filter_methods.dart';

TextEditingController searchController = TextEditingController();
AppBar buildAppBarSearch(
    BuildContext context, SearchFilter selectedDropDown, WidgetRef ref) {
  /// When [todoListProvider] changes, this method will be called to change the [searchProvider] based on the [searchFilterProvider].
  ref.listen(todoListProvider, (previous, next) {
    switch (ref.watch(searchFilterProvider)) {
      case SearchFilter.All:
        filterAll(searchController.text, ref);
      case SearchFilter.Title:
        filterTitle(searchController.text, ref);
      case SearchFilter.Description:
        filterDescription(searchController.text, ref);
      case SearchFilter.Tag:
        filterTag(searchController.text, ref);
    }
  });

  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: BackButton(
      color: Colors.black,
      onPressed: () {
        Navigator.pop(context);
        ref.watch(searchProvider.notifier).update(
              (state) => [],
            );
        searchController.clear();
      },
    ),
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.45,
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search To Do'.tr(context: context),
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              suffixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            onChanged: (value) {
              switch (ref.watch(searchFilterProvider)) {
                case SearchFilter.All:
                  filterAll(value, ref);
                case SearchFilter.Title:
                  filterTitle(value, ref);
                case SearchFilter.Description:
                  filterDescription(value, ref);
                case SearchFilter.Tag:
                  filterTag(value, ref);
              }
            },
          ),
        ),
        const Spacer(),
        DropdownButton(
          iconEnabledColor: Colors.black,
          value: selectedDropDown,
          items: SearchFilter.values.toList().map(
            (e) {
              return DropdownMenuItem(
                value: e,
                child: Text(
                  e.name.tr(context: context),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ).toList(),
          onChanged: (value) {
            ref.watch(searchFilterProvider.notifier).update(
                  (state) => value as SearchFilter,
                );
          },
        ),
      ],
    ),
  );
}
