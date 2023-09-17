import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

AppBar buildTagAddingScreenAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: Text(
      'Your Tags'.tr(context: context),
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    ),
  );
}
