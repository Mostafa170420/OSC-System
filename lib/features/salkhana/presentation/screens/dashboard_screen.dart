import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_states.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/sidebar_cubit.dart';
import 'package:osc_system/features/salkhana/presentation/widgets/member_table.dart';
import '../../../../core/responsive.dart';
import '../widgets/dashboard_details.dart';
import '../widgets/members_info_table.dart';
import '../widgets/members_table.dart';
import '../widgets/sidebar.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  List<Widget> screens = [
    DashboardDetails(),
    MembersInfoTable(),
    Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SidebarCubit(),
      child: Scaffold(
        body: Row(
          children: [
            Responsive.isDesktop(context)
                ? Expanded(
                    child: Container(
                      color: Theme.of(context).canvasColor,
                      child: Sidebar(),
                    ),
                  )
                : SizedBox(),
            Expanded(
                flex: 5,
                child: BlocBuilder<SidebarCubit, int>(
                  builder: (context, state) => screens[state],
                )),
          ],
        ),
      ),
    );
  }
}
