import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/sidebar_cubit.dart';
import 'package:osc_system/features/salkhana/presentation/screens/mobile/dashboard.dart';
import '../../../../core/responsive.dart';
import '../widgets/dashboard_details.dart';
import '../widgets/members_info_table.dart';
import '../widgets/sidebar.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static List<Widget> screens = [
    DashboardDetails(),
    MembersInfoTable(),
    Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SidebarCubit(),
        child: Scaffold(
          key: _scaffoldKey,
          extendBodyBehindAppBar: true,
          appBar: !Responsive.isDesktop(context)
              ? AppBar(
                  leading: IconButton(
                      onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                      icon: Icon(
                        Icons.menu,
                        color: Theme.of(context).primaryColor,
                      )),
                )
              : null,
          drawer: Sidebar(),
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
              Expanded(flex: 5, child: Dashboard()),
            ],
          ),
        ));
  }
}
