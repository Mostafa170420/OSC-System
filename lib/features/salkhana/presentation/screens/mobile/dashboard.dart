import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/sidebar_cubit.dart';
import '../dashboard_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SidebarCubit, int>(
      builder: (context, state) => DashboardScreen.screens[state],
    );
  }
}
