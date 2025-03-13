import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/salkhana_cubit.dart';
import '../cubit/salkhana_states.dart';
import '../widgets/member_table.dart';
import '../widgets/sidebar.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252728),
      appBar: AppBar(centerTitle: true, title: Text("Members")),
      drawer: Sidebar(),
      body: BlocConsumer<SalkhanaCubit, SalkhanaStates>(
          buildWhen: (previous, current) => (current is SalkhanaSuccsses ||
              current is SalkhanaLoading ||
              current is SalkhanaFailureNetwork),
          listener: (context, state) {
            if (state is SalkhanaSuccssesFirestore) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Successfully")));
            }
          },
          builder: (context, state) {
            if (state is SalkhanaSuccsses) {
              
              return MemberTable(members: state.members);
            }
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          }),
    );
  }
}
