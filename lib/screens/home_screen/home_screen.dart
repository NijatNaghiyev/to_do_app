import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:codelandia_to_do_riverpod/constant/sized_box.dart';
import 'package:codelandia_to_do_riverpod/providers/filters_provider.dart';
import 'package:codelandia_to_do_riverpod/screens/chart_screen/chart_screen.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/methods/alarm_methods.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/custom_app_bar.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/empty_list_image.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/filter_buttons.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/float_action_button.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/to_do_card_widget.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/welcome_bar_widget.dart';
import 'package:codelandia_to_do_riverpod/screens/new_todo/new_todo_screen.dart';
import 'package:codelandia_to_do_riverpod/screens/search_screen/search_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_actions/quick_actions.dart';

import '../../generated/assets.dart';
import '../../providers/tags_list.dart';
import '../../providers/todo_list_provider.dart';
import 'drawer/drawer_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static StreamSubscription? subscription;

  final ScrollController _scrollController = ScrollController();

  /// Quick Actions
  QuickActions quickActions = const QuickActions();

  @override
  void initState() {
    super.initState();
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(context, alarmSettings),
    );
  }

  /// Quick Actions Init
  initializeQuickActions() {
    quickActions.initialize(
      (type) {
        switch (type) {
          case 'Add To Do':
            ref.watch(tagsListProvider.notifier).newToDo();

            navigateToScreens(
              NewTodo(
                todoModel: null,
                appBarTitle: 'New To Do'.tr(context: context),
              ),
            );
          case 'Search To Do':
            navigateToScreens(
              const SearchScreen(),
            );
          case 'Chart':
            navigateToScreens(
              const ChartScreen(),
            );
          default:
            navigateToScreens(const HomeScreen());
        }
      },
    );

    quickActions.setShortcutItems(
      <ShortcutItem>[
        ShortcutItem(
          type: 'Add To Do',
          localizedTitle: 'Add To Do'.tr(context: context),
          icon: 'plus1',
        ),
        ShortcutItem(
          type: 'Search To Do',
          localizedTitle: 'Search To Do'.tr(context: context),
          icon: 'search1',
        ),
        ShortcutItem(
          type: 'Chart',
          localizedTitle: 'Chart'.tr(context: context),
          icon: 'chart1',
        ),
      ],
    );
  }

  navigateToScreens(Widget screen) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false);

    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Quick Actions Init
    initializeQuickActions();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoList = ref.watch(todoListProvider);
    var filtersList = ref.watch(filterListProvider);
    var filterPro = ref.watch(filterProvider);

    return Scaffold(
      drawer: const DrawerScreen(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.sizeOf(context).height * 0.1,
            ),
            child: Column(
              children: [
                const CustomAppBar(),
                kSizedBoxH10,
                const WelcomeBarWidget(),
                const FilterButtons(),
                todoList.isEmpty
                    ? EmptyListImage(
                        title: 'Your To Do List is Empty'.tr(context: context),
                        image: Assets.imagesEmptyList,
                      )
                    : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        child: ListView.builder(
                          key: ValueKey(filterPro),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _scrollController,
                          itemCount: filtersList.length,
                          itemBuilder: (context, index) => ToDoCardWidget(
                            indexCard: todoList.indexOf(filtersList[index]),
                            key: ValueKey(filtersList[index].id),
                            todoModel: filtersList[index],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const FloatActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
