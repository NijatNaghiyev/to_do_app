import 'package:codelandia_to_do_riverpod/screens/chart_screen/chart_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../providers/selected_languages_provider.dart';

class DrawerScreen extends ConsumerWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedLanguage = ref.watch(selectedLanguageProvider);

    return SafeArea(
      child: Drawer(
        shape: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'To Do List',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        locale: Localizations.localeOf(context),
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChartScreen(),
                    ),
                  );
                },
                leading: const Icon(
                  Icons.pie_chart_rounded,
                  color: Colors.black,
                ),
                title: Text(
                  'Chart'.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                trailing: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton(
                    value: selectedLanguage,
                    items: const [
                      DropdownMenuItem(
                        value: 'en_US',
                        child: Text('En'),
                      ),
                      DropdownMenuItem(
                        value: 'az_AZ',
                        child: Text('Az'),
                      ),
                    ],
                    onChanged: (value) async {
                      ref.watch(selectedLanguageProvider.notifier).update(
                            (state) => value!,
                          );
                      if (value == 'en_US') {
                        await context.setLocale(context.supportedLocales[0]);
                        Hive.box('todoBox').put('selectedLanguage', value);
                      } else if (value == 'az_AZ') {
                        await context.setLocale(context.supportedLocales[1]);
                        Hive.box('todoBox').put('selectedLanguage', value);
                      }
                    },
                  ),
                ),
                title: Text(
                  'Language'.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              // ListTile(
              //   onTap: () {},
              //   leading: const Icon(
              //     Icons.info,
              //     color: Colors.black,
              //   ),
              //   title: Text(
              //     'About'.tr(),
              //     style: const TextStyle(
              //       color: Colors.black,
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
              const Spacer(),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Version 1.0.0'.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
