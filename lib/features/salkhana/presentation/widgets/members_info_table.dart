import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/core/responsive.dart';
import 'package:osc_system/features/salkhana/data/model/member.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_states.dart';
import 'package:osc_system/features/salkhana/presentation/widgets/add_member_dialog.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constant/content.dart';

class MembersInfoTable extends StatelessWidget {
  MembersInfoTable({super.key});
  var dropdownTitle = "Flutter";
  @override
  Widget build(BuildContext context) {
    dropdownTitle = "Flutter";

    Size size = MediaQuery.of(context).size;
    return BlocBuilder<SalkhanaCubit, SalkhanaStates>(
      buildWhen: (previous, current) =>
          current is SalkhanaLoading || current is SalkhanaSuccsses,
      builder: (context, state) {
        print(state);
        return Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Members",
                        maxLines: 1,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontSize: 25),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 55,
                        width: 150,
                        child: MaterialButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Color(0xFF212332),
                                content: AddMemberDialog(),
                              ),
                            );
                          },
                          color: Color(0xffef7905),
                          height: 55,
                          minWidth: 150,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: FittedBox(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person_add_alt_1_outlined,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Add New",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width / 5,
                    child: DropdownButton(
                        isExpanded: true,
                        iconEnabledColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        menuWidth: 300,
                        value: dropdownTitle,
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
                          fit: BoxFit.scaleDown,
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
                                  "Email",
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
                                  "Attendance",
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
              DataCell(Center(
                child: Text(
                  member.email,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              )),
              DataCell(Center(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Image.asset(
                      committeeImagePath(member.committee1),
                      width: 30,
                    ),
                  ),
                  Text(
                    member.committee1,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ))),
              DataCell(Center(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Image.asset(
                      committeeImagePath(member.committee2),
                      width: 30,
                    ),
                  ),
                  Text(
                    member.committee2,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ))),
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
              DataCell(Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Remove"),
                        onTap: () => BlocProvider.of<SalkhanaCubit>(context)
                            .removeMember(member.id),
                      ),
                      PopupMenuItem(
                        child: Text("Update"),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Color(0xFF212332),
                              content: AddMemberDialog(
                                member: member,
                              ),
                            ),
                          );
                        },
                      )
                    ],
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

  String committeeImagePath(String name) {
    String path = '';
    for (var element in committees) {
      if (element[1] == name) path = element[0];
    }
    return path;
  }

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
