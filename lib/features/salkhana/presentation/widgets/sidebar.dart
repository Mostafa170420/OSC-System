import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/sidebar_cubit.dart';
import 'package:osc_system/features/salkhana/presentation/widgets/dashboard_details.dart';

import '../screens/settings_screen.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    print('object');
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(25),
              child: Image.asset("assets/images/OSC_logo.png"),
            ),
            DrawerListTile(
                icon: Icons.dashboard, title: "Dashboard", screenIndex: 0),
            DrawerListTile(
                icon: Icons.people, title: "Members", screenIndex: 1),
            DrawerListTile(
                icon: Icons.settings, title: "Settings", screenIndex: 2)
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.icon,
    required this.title,
    this.screenIndex,
  });
  final IconData icon;
  final String title;
  final screenIndex;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 60,
      contentPadding: EdgeInsets.only(left: 20),
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => DashboardDetails(),
        //     ));
        BlocProvider.of<SalkhanaCubit>(context).changeCommittee("");
        BlocProvider.of<SidebarCubit>(context).changeScreen(screenIndex);
      },
      horizontalTitleGap: 30,
      leading: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.clip,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
