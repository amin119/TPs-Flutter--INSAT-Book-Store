import 'package:flutter/material.dart';

/// A very small global theme controller using a ValueNotifier.
/// Toggle theme by calling [toggleTheme()].
final ValueNotifier<bool> isDarkTheme = ValueNotifier<bool>(false);

void toggleTheme() {
  isDarkTheme.value = !isDarkTheme.value;
}
