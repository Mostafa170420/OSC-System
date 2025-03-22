import 'package:flutter/material.dart';

import 'members_table.dart';

class MobileDashboardDetails extends StatelessWidget {
  const MobileDashboardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
      child: MembersTable(),
    );
  }
}
