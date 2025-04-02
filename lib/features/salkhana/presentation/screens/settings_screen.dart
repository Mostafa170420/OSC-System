import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/salkhana/presentation/screens/auth/login_screen.dart';
import 'package:osc_system/features/salkhana/presentation/screens/dashboard_screen.dart';

import '../cubit/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Text(
              "Account",
              style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
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
                  style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  // Navigate to Profile edit screen
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
                  style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  // Navigate to Security settings
                },
              ),
            ),
            const SizedBox(height: 20),

            
            Text(
              "Appearance",
              style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
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
                  style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                value: theme.brightness == Brightness.dark,
                onChanged: (value) => context.read<ThemeCubit>().toggleTheme(),
                secondary: Icon(
                  Icons.dark_mode,
                  color: theme.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 20),

  
            Text(
              "Preferences",
              style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
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
                  style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  "English",
                  style: theme.textTheme.labelSmall?.copyWith(color: Colors.grey),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
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
                leading: Icon(Icons.notifications, color: theme.primaryColor),
                title: Text(
                  "Notifications",
                  style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {
                           Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                  },
                ),
              ),
            ),
           
            
          
          ],
        ),
      ),
    );
  }
}
