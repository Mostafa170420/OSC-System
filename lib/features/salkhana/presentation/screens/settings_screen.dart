import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/theme_cubit.dart';
import '../widgets/sidebar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Settings")),
      drawer: Sidebar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          child: Text("Toggle Theme"),
        ),
      ),
    );
  }
}
