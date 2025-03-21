import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '/features/salkhana/presentation/cubit/theme_states.dart';
import '../../../../core/theme/theme.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(DarkThemeState());

  void toggleTheme() {
    if (state is LightThemeState) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }

  ThemeData get currentTheme {
    return AppThemes.darkTheme;
  }
}
