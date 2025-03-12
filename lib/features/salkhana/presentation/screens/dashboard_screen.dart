import 'package:flutter/material.dart';
import '../../../../core/responsive.dart';
import '../widgets/dashboard_details.dart';
import '../widgets/sidebar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Expanded(flex: 5, child: DashboardDetails()),
        ],
      ),
    );
  }
}
