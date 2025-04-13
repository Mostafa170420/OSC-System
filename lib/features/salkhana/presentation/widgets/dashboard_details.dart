import 'package:flutter/material.dart';

import '../../../../core/responsive.dart';
import '../screens/dashboard_screen.dart';
import 'dashboard_app_bar.dart';
import 'desktop_dashboard_details.dart';
import 'members_table.dart';
import 'mobile_dashboard_app_bar.dart';
import 'mobile_dashboard_details.dart';
import 'right_sidebar.dart';

class DashboardDetails extends StatelessWidget {
  const DashboardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: Responsive.isDesktop(context)
            ? PreferredSize(
                preferredSize: Size(size.width, 85), child: DashboardAppBar())
            : MobileDashboardAppBar(),
        body: Responsive(
          mobile: MobileDashboardDetails(),
          desktop: DesktopDashboardDetails(),
          tablet: DesktopDashboardDetails(),
        ));
  }
}
