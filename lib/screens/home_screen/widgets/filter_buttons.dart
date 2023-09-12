import 'package:codelandia_to_do_riverpod/providers/filters_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/sized_box.dart';

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
          buildFilledButtonFilter(ref, Filter.all, 'All'),
          kSizedBoxW20,
          buildFilledButtonFilter(ref, Filter.ongoing, 'Ongoing'),
          kSizedBoxW20,
          buildFilledButtonFilter(ref, Filter.done, 'Done'),
        ],
      ),
    );
  }

  FilledButton buildFilledButtonFilter(
      WidgetRef ref, Filter filter, String title) {
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
        title,
        style: TextStyle(
          color:
              ref.watch(filterProvider) == filter ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
