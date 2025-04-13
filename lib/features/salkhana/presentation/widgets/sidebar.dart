import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../../core/responsive.dart';
import '../cubit/salkhana_cubit.dart';
import '../cubit/sidebar_cubit.dart';
import '../screens/settings_screen.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.controller});
  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SidebarX(
      controller: controller,
      headerBuilder: (context, extended) {
        return DrawerHeader(
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Image.asset("assets/images/OSC_logo.png"),
              Shimmer.fromColors(
                enabled: true,
                period: Duration(seconds: 2),
                baseColor: Colors.transparent,
                highlightColor: Colors.white38,
                child: Image.asset("assets/images/OSC_logo.png"),
              ),
            ],
          ),
        );
      },
      extendedTheme: SidebarXTheme(
          width:
              Responsive.isDesktop(context) ? size.width / 5 : size.width / 3),
      theme: SidebarXTheme(
        hoverColor: Theme.of(context).hoverColor.withOpacity(0.1),
        selectedItemDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        itemTextPadding: EdgeInsets.symmetric(horizontal: 20),
        selectedItemTextPadding: EdgeInsets.symmetric(horizontal: 20),
        textStyle: Theme.of(context).textTheme.labelMedium,
        hoverTextStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
        selectedTextStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
        itemDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(12),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(12),
        ),
        iconTheme: Theme.of(context).iconTheme,
        selectedIconTheme: Theme.of(context).iconTheme.copyWith(
              color: Theme.of(context).primaryColor,
              size: 26,
            ),
        hoverIconTheme: IconThemeData(
          color: Theme.of(context).primaryColor.withOpacity(0.7),
          size: 26,
        ),
      ),
      items: [
        SidebarXItem(
          icon: Icons.dashboard,
          label: "Dashboard",
          onTap: () {
            BlocProvider.of<SalkhanaCubit>(context).changeCommittee("");
            BlocProvider.of<SidebarCubit>(context).changeScreen(0);
          },
        ),
        SidebarXItem(
          icon: Icons.people,
          label: "Members",
          onTap: () {
            BlocProvider.of<SalkhanaCubit>(context).changeCommittee("");
            BlocProvider.of<SidebarCubit>(context).changeScreen(1);
          },
        ),
        SidebarXItem(
          icon: Icons.settings,
          label: "Settings",
          onTap: () {
            BlocProvider.of<SalkhanaCubit>(context).changeCommittee("");
            BlocProvider.of<SidebarCubit>(context).changeScreen(2);
          },
        ),
      ],
    );
  }
}
