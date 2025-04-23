import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../cubit/salkhana_cubit.dart';
import '../cubit/theme_cubit.dart';
import 'auth/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Icon(
                Icons.settings,
                color: theme.primaryColor,
                size: 36,
              ),
            ),
            Flexible(
                child: Text("Settings", style: theme.textTheme.titleLarge)),
          ],
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 200),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              Text(
                "Account",
                style: theme.textTheme.labelMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Card(
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.person, color: theme.primaryColor),
                  title: Text(
                    "Profile",
                    style: theme.textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey),
                  onTap: () {
                    BlocProvider.of<SalkhanaCubit>(context).getMembers();
                  },
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.security, color: theme.primaryColor),
                  title: Text(
                    "Security",
                    style: theme.textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey),
                  onTap: () {
                    // Navigate to Security settings
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Appearance",
                style: theme.textTheme.labelMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Card(
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SwitchListTile(
                  title: Text(
                    "Dark Mode",
                    style: theme.textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  value: theme.brightness == Brightness.dark,
                  onChanged: (value) =>
                      context.read<ThemeCubit>().toggleTheme(),
                  secondary: Icon(
                    Icons.dark_mode,
                    color: theme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Preferences",
                style: theme.textTheme.labelMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Card(
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.language, color: theme.primaryColor),
                  title: Text(
                    "Language",
                    style: theme.textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    "English",
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: Colors.grey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey),
                  onTap: () {
                    // Navigate to Language settings
                  },
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.download, color: theme.primaryColor),
                  title: Text(
                    "Download from Server",
                    style: theme.textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {
                      BlocProvider.of<SalkhanaCubit>(context).downloadMembers();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.upload, color: theme.primaryColor),
                  title: Text(
                    "Upload to Server",
                    style: theme.textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {
                      BlocProvider.of<SalkhanaCubit>(context).uploadMembers();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
