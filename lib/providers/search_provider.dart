import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/search_filter_enum.dart';

var searchFilterProvider = StateProvider<SearchFilter>(
  (ref) => SearchFilter.values[0],
);

var searchProvider = StateProvider<List<TodoModel>>(
  (ref) => [],
);
