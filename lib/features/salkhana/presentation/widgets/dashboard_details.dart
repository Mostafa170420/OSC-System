import 'package:flutter/material.dart';

import '../../../../core/responsive.dart';
import 'dashboard_app_bar.dart';
import 'members_table.dart';
import 'right_sidebar.dart';

class DashboardDetails extends StatelessWidget {
  const DashboardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(size.width, 85), child: DashboardAppBar()),
      body: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: MembersTable(),
            ),
          ),
          !Responsive.isMobile(context)
              ? Expanded(child: RightSidebar())
              : SizedBox()
        ],
      ),
    );
  }
}
