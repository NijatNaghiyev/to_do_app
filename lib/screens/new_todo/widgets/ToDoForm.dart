import 'dart:async';

import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:codelandia_to_do_riverpod/providers/form_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/sized_box.dart';
import '../../../providers/isCreating_provider.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class ToDoForm extends ConsumerStatefulWidget {
  final TodoModel? todoModel;
  const ToDoForm({
    required this.todoModel,
    super.key,
  });

  @override
  ConsumerState<ToDoForm> createState() => _ToDoFormState();
}

class _ToDoFormState extends ConsumerState<ToDoForm> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController? descTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Timer(Duration.zero, () {
      if (!ref.watch(isCreatingProvider)) {
        titleTextController.text = widget.todoModel!.title;
        descTextController?.text = widget.todoModel!.description!;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleTextController.dispose();
    descTextController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleTextController,
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
                titleTextController.text = newValue!;
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
              controller: descTextController,
              onSaved: (newValue) {
                ref
                    .watch(descriptionProvider.notifier)
                    .update((state) => state = newValue);
                descTextController?.text = newValue!;
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
