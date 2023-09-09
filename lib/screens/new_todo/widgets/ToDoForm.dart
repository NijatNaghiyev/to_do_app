import 'package:codelandia_to_do_riverpod/providers/form_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/sized_box.dart';

class ToDoForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const ToDoForm({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.length > 50) {
                  return 'Must be between 2 and 50 characters.';
                }
                return null;
              },
              onSaved: (newValue) {
                ref
                    .watch(titleProvider.notifier)
                    .update((state) => state = newValue!);
              },
              onChanged: (value) {
                ref
                    .watch(titleProvider.notifier)
                    .update((state) => state = value);
              },
              maxLines: null,
              maxLength: 50,
              decoration: InputDecoration(
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
                label: const Text('Title*'),
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                hintText: 'Enter your title',
              ),
            ),
            kSizedBoxH20,
            TextFormField(
              onSaved: (newValue) {
                ref
                    .watch(descriptionProvider.notifier)
                    .update((state) => state = newValue);
              },
              onChanged: (value) {
                ref
                    .watch(descriptionProvider.notifier)
                    .update((state) => state = value);
              },
              maxLines: null,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
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
                label: const Text('Description'),
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                hintText: 'Enter your description',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
