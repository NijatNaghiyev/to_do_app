import 'dart:async';

import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:codelandia_to_do_riverpod/providers/form_providers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/sized_box.dart';
import '../../../providers/isCreating_provider.dart';

class ToDoForm extends ConsumerStatefulWidget {
  final TodoModel? todoModel;
  final GlobalKey<FormState> formKey;

  const ToDoForm({
    required this.formKey,
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
    Timer(
      Duration.zero,
      () {
        if (!ref.watch(isCreatingProvider)) {
          titleTextController.text = widget.todoModel!.title;
          if (widget.todoModel!.description != null) {
            descTextController?.text = widget.todoModel!.description!;
          }
        }
      },
    );
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
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: titleTextController,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.length > 50) {
                  return 'Must be between 2 and 50 characters.'
                      .tr(context: context);
                }
                return null;
              },
              onSaved: (newValue) {
                ref
                    .watch(titleProvider.notifier)
                    .update((state) => state = newValue!);
                titleTextController.text = newValue!.trim();
              },
              onChanged: (value) {
                ref.watch(titleProvider.notifier).update(
                      (state) => state = value.trim(),
                    );
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
                label: Text('Title*'.tr(context: context)),
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                hintText: 'Enter your title'.tr(context: context),
              ),
            ),
            kSizedBoxH20,
            TextFormField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: descTextController,
              onSaved: (newValue) {
                if (newValue != null && newValue.trim().isNotEmpty) {
                  ref.watch(descriptionProvider.notifier).update(
                        (state) => state = newValue.trim(),
                      );
                }
                descTextController?.text = newValue!;
              },
              onChanged: (value) {
                ref.watch(descriptionProvider.notifier).update(
                      (state) => state = value.trim(),
                    );
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
                label: Text('Description'.tr(context: context)),
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                hintText: 'Enter your description'.tr(context: context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
