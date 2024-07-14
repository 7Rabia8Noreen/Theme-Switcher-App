import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_switcher_app/bloc/theme_switcher_event.dart';

class ThemeSwitcherBloc extends Bloc<ThemeSwitcherEvent, ThemeData> {
  ThemeSwitcherBloc() : super(ThemeData.light()) {
    on<SetInitialTheme>((event, emit) async {
      final hasThemeDark = await isDark();

      emit(hasThemeDark ? ThemeData.dark() : ThemeData.light());
    });

    on<ThemeSwitching>((event, emit) async {
      final hasThemeDark = state == ThemeData.dark();
      emit(hasThemeDark ? ThemeData.light() : ThemeData.dark());
      await setTheme(!hasThemeDark);
    });
  }
}

Future<bool> isDark() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  return sharedPreferences.getBool('is_dark') ?? false;
}

Future<void> setTheme(bool isDark) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sharedPreferences.setBool('is_dark', isDark);
}
