import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:osc_system/features/salkhana/presentation/screens/emails_screen.dart';

import '../../../../core/responsive.dart';
import '../cubit/salkhana_cubit.dart';
import '../cubit/salkhana_states.dart';
import '../cubit/sidebar_cubit.dart';
import '../widgets/dashboard_details.dart';
import 'members_screen.dart';
import '../widgets/sidebar.dart';
import 'mobile/dashboard.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static List<Widget> screens = [
    DashboardDetails(),
    MembersScreen(),
    EmailScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<SalkhanaCubit, SalkhanaStates>(
      listener: (context, state) {
        if (state is SalkhanaUploadSuccsses) {
          MotionToast.success(
            title: Text("Uploading Sucsses"),
            toastAlignment: Alignment.topLeft,
            animationType: AnimationType.slideInFromLeft,
            description: SizedBox(),
            animationDuration: Duration(milliseconds: 400),
            animationCurve: TreeSliver.defaultAnimationCurve,
            opacity: 0.95,
          ).show(context);
        } else if (state is SalkhanaDownloadSuccsses) {
          MotionToast.success(
            title: Text("Downloading Sucsses"),
            toastAlignment: Alignment.topLeft,
            animationType: AnimationType.slideInFromLeft,
            description: SizedBox(),
            animationDuration: Duration(milliseconds: 400),
            animationCurve: TreeSliver.defaultAnimationCurve,
            opacity: 0.95,
          ).show(context);
        }
      },
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
        drawer: Sidebar(
          controller: SidebarCubit.get(context).controller,
        ),
        body: Row(
          children: [
            Responsive.isDesktop(context)
                ? Container(
                    color: Theme.of(context).canvasColor,
                    child: Sidebar(
                      controller: SidebarCubit.get(context).controller,
                    ),
                  )
                : SizedBox(),
            Expanded(flex: 5, child: Dashboard()),
          ],
        ),
      ),
    );
  }
}
