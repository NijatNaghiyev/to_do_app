// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:codelandia_to_do_riverpod/constant/sized_box.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/custom_app_bar.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/filter_buttons.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/float_action_button.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/to_do_card_widget.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/welcome_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/todo_list_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final todoList = ref.watch(todoListProvider);
    // var reversedTodoList = List.from(todoList);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.sizeOf(context).height * 0.1,
            ),
            child: Column(
              children: [
                CustomAppBar(),
                kSizedBoxH10,
                WelcomeBarWidget(),
                FilterButtons(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: todoList.length,
                  itemBuilder: (context, index) => ToDoCardWidget(
                    indexCard: index,
                    key: ValueKey(todoList[index].id),
                    todoModel: todoList[index],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
