import 'package:flutter_riverpod/flutter_riverpod.dart';

var titleProvider = StateProvider<String>((ref) => '');
var descriptionProvider = StateProvider<String?>((ref) => null);
