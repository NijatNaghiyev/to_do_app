import 'package:codelandia_to_do_riverpod/constant/sized_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/todo_list_provider.dart';

class ChartScreen extends ConsumerWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todoList = ref.watch(todoListProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Chart'.tr(context: context),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              child: PieChart(
                PieChartData(
                  centerSpaceColor: Colors.blue,
                  sections: [
                    PieChartSectionData(
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      radius: 100,
                      color: Colors.red,
                      value: todoList
                          .where((element) => !element.isDone)
                          .toList()
                          .length
                          .toDouble(),
                      title:
                          '${(todoList.where((element) => !element.isDone).toList().length.toDouble() / todoList.length.toDouble() * 100.0).toStringAsFixed(2)}%',
                    ),
                    PieChartSectionData(
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      radius: 100,
                      color: Colors.green,
                      value: todoList
                          .where((element) => element.isDone)
                          .toList()
                          .length
                          .toDouble(),
                      title:
                          '${(todoList.where((element) => element.isDone).toList().length.toDouble() / todoList.length.toDouble() * 100.0).toStringAsFixed(2)}%',
                    ),
                  ],
                ),
              ),
            ),
            kSizedBoxH20,
            ListTile(
              leading: const Icon(
                Icons.circle,
                color: Colors.blue,
              ),
              title: Text(
                'All'.tr(context: context),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                todoList.length.toString(),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.circle,
                color: Colors.green,
              ),
              title: Text(
                'Done'.tr(context: context),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                todoList
                    .where((element) => element.isDone)
                    .toList()
                    .length
                    .toString(),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.circle,
                color: Colors.red,
              ),
              title: Text(
                'Ongoing'.tr(context: context),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                todoList
                    .where((element) => !element.isDone)
                    .toList()
                    .length
                    .toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
