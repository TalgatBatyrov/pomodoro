import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeData.light());

  bool get isLight => state.brightness == Brightness.light;

  void toggleTheme() {
    if (isLight) {
      emit(ThemeData.dark());
    } else {
      emit(ThemeData.light());
    }
  }
}
