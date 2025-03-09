import 'package:flutter/material.dart';

import '../screens/dashboard_screen.dart';
import '../screens/members_screen.dart';
import '../screens/settings_screen.dart';



class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;

        Widget menu = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Image.asset('assets/images/OSC_logo.png', width: 80),
                  SizedBox(height: 10),
                  Text("OSC System", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 22)),
                ],
              ),
            ),
            SidebarItem(icon: Icons.dashboard, title: "Dashboard", screen: DashboardScreen()),
            SidebarItem(icon: Icons.people, title: "Members", screen: MembersScreen()),
            SidebarItem(icon: Icons.settings, title: "Settings", screen: SettingsScreen()),
          ],
        );

        return isDesktop
            ? Container(
                width: 250,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: menu,
              )
            : Drawer(child: menu);
      },
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget screen;

  SidebarItem({required this.icon, required this.title, required this.screen});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title, style: TextStyle(color: Theme.of(context).primaryColor)),
      onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => screen)),
    );
  }
}
