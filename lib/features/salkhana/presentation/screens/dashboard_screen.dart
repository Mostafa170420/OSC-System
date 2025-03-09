import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/salkhana_cubit.dart';
import '../cubit/salkhana_states.dart';
import '../widgets/sidebar.dart';
import '../widgets/member_table.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;
        
        return Scaffold(
          appBar: isDesktop
              ? null  // No app bar for desktop since Sidebar is always visible
              : AppBar(
                  title: Text("Dashboard"),
                  leading: Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ),
          drawer: isDesktop ? null : Sidebar(), // Sidebar as a drawer on mobile
          body: Row(
            children: [
              if (isDesktop) Sidebar(), // Sidebar always visible on desktop
              Expanded(
                child: BlocConsumer<SalkhanaCubit, SalkhanaStates>(
                  buildWhen: (previous, current) =>
                      (current is SalkhanaSuccsses ||
                          current is SalkhanaLoading ||
                          current is SalkhanaFailureNetwork),
                  listener: (context, state) {
                    if (state is SalkhanaSuccssesFirestore) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Successfully")),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SalkhanaSuccsses) {
                      return MemberTable(members: state.members);
                    }
                    return Center(child: CircularProgressIndicator(color:Theme.of(context).primaryColor,));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
