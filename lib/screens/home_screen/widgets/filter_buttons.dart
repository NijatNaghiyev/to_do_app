import 'package:codelandia_to_do_riverpod/providers/filters_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/sized_box.dart';
import '../../../data/model/filter_button.dart';

class FilterButtons extends ConsumerWidget {
  const FilterButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildFilledButtonFilter(context, ref, Filter.all, 'All'),
          kSizedBoxW20,
          buildFilledButtonFilter(context, ref, Filter.ongoing, 'Ongoing'),
          kSizedBoxW20,
          buildFilledButtonFilter(context, ref, Filter.done, 'Done'),
        ],
      ),
    );
  }

  FilledButton buildFilledButtonFilter(
      BuildContext context, WidgetRef ref, Filter filter, String title) {
    return FilledButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          const BorderSide(
            color: Colors.black,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          ref.watch(filterProvider) == filter ? Colors.black : Colors.white,
        ),
      ),
      onPressed: () {
        ref.watch(filterProvider.notifier).update((state) => filter);
      },
      child: Text(
        title.tr(context: context),
        style: TextStyle(
          color:
              ref.watch(filterProvider) == filter ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
