import 'package:flutter/material.dart';

import 'members_table.dart';
import 'right_sidebar.dart';

class DesktopDashboardDetails extends StatelessWidget {
  const DesktopDashboardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            child: MembersTable(),
          ),
        ),
        Expanded(child: RightSidebar())
      ],
    );
  }
}
