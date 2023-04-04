import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return SchedulerBinding.instance.window.platformBrightness == Brightness.dark
      ? ThemeMode.dark
      : ThemeMode.light;
});
