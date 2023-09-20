import 'package:flutter/material.dart';

class PickerThemeCustom extends StatelessWidget {
  final Widget? child;
  const PickerThemeCustom({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: Colors.black, // header background color
          onPrimary: Colors.white, // header text color
          onSurface: Colors.black, // body text color
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black, // button text color
          ),
        ),
      ),
      child: child!,
    );
  }
}
