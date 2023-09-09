import 'package:flutter/material.dart';

import '../../../constant/sized_box.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(
                  color: Colors.black,
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: () {},
            child: const Text('All'),
          ),
          kSizedBoxW20,
          FilledButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(
                  color: Colors.black,
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {},
            child: const Text(
              'Upcoming',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          kSizedBoxW10,
          FilledButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(
                  color: Colors.black,
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {},
            child: const Text(
              'Task Done',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
