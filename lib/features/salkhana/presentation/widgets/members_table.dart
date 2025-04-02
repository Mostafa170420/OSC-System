import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/salkhana/data/model/member.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/drop_down_cubit.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_states.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constant/content.dart';
import '../../../../core/constant/functions.dart';

class MembersTable extends StatelessWidget {
  MembersTable({super.key});
  var dropdownTitle = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => DropDownCubit(),
      child: BlocBuilder<SalkhanaCubit, SalkhanaStates>(
        buildWhen: (previous, current) =>
            current is SalkhanaLoading ||
            current is SalkhanaSuccsses ||
            current is SalkhanaFailureNetwork,
        builder: (context, state) {
          print(state);
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Members",
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 25),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            blurRadius: 10, // Spread of the shadow
                            offset: Offset(0, 5), // Position of the shadow
                          ),
                        ],
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.2), // Border color
                          width: 1, // Border width
                        ),
                      ),
                      width: size.width / 5,
                      child: DropdownButton(
                          underline: SizedBox(),
                          dropdownColor: Theme.of(context).cardColor,
                          isExpanded: true,
                          iconEnabledColor: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          menuWidth: 300,
                          value: dropdownTitle,
                          alignment: AlignmentDirectional.center,
                          items: items,
                          style: TextStyle(),
                          onChanged: (value) {
                            dropdownTitle = value;
                            BlocProvider.of<SalkhanaCubit>(context)
                                .changeCommittee(value);
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Skeletonizer(
                    enabled: (state is SalkhanaSuccsses ||
                            state is SalkhanaSuccssesFirestore)
                        ? false
                        : true,
                    child: ListView(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: Text(
                                    "Name",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: Text(
                                    "Phone",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: Text(
                                    "Committee 1",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: Text(
                                    "Committee 2",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: Text(
                                    "Actions",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ],
                              rows: _buildTableRows(
                                  context,
                                  (state is SalkhanaSuccsses)
                                      ? state.members
                                      : faceList),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  List<DataRow> _buildTableRows(context, List<SalkhanaMemberModel> members) {
    return members
        .map(
          (member) => DataRow(
            cells: [
              DataCell(Center(
                child: Text(
                  member.name,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              )),
              DataCell(Center(
                child: Text(
                  member.phone,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              )),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Image.asset(
                        committeeImagePath(member.committee1),
                        width: 30,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        member.committee1,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Image.asset(
                        committeeImagePath(member.committee2),
                        width: 30,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        member.committee2,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      member.attendanceDate =
                          member.attendanceDate.isEmpty ? "attend" : "";
                      BlocProvider.of<SalkhanaCubit>(context)
                          .updateMember(member);
                    },
                    child: member.attendanceDate.isEmpty
                        ? Text("not Attend",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.red))
                        : Text("Attend",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.green)),
                  )
                ],
              ))),
            ],
          ),
        )
        .toList();
  }

  List<DropdownMenuItem> items = List.generate(
    committees.length,
    (index) => DropdownMenuItem(
      alignment: AlignmentDirectional.center,
      value: committees[index][1],
      child: Row(
        children: [
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(committees[index][0]),
          )),
          Flexible(
            child: Text(
              committees[index][1],
              style: TextStyle(color: Colors.white),
              maxLines: 1,
            ),
          ),
        ],
      ),
    ),
  );
  List<SalkhanaMemberModel> faceList = List.generate(
    5,
    (index) => SalkhanaMemberModel(
        id: "5",
        name: "Mostafa Ahmed",
        email: "email",
        phone: "01009682965",
        academicYear: "academicYear",
        college: "college",
        committee1: "committee1",
        committee2: "committee2",
        attendanceDate: "sdf",
        resultCommittee1: "resultCommittee1",
        resultCommittee2: "resultCommittee2",
        emailSent: false),
  ).toList();
}
