import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import '../../../../core/constant/constant.dart';
import '../cubit/salkhana_states.dart';
import 'members_table.dart';
import 'right_sidebar.dart';

class DesktopDashboardDetails extends StatelessWidget {
  const DesktopDashboardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: MembersTable(),
          ),
        ),
        Expanded(
            child: BlocBuilder<SalkhanaCubit, SalkhanaStates>(
          buildWhen: (previous, current) => current is SalkhanaSuccsses,
          builder: (context, state) {
            return RightSidebar(
              committees: convertToListOfLists(committees),
              members: SalkhanaCubit.get(context).members,
            );
          },
        )),
      ],
    );
  }
}
