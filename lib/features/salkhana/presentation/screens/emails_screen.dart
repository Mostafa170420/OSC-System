// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/salkhana/presentation/widgets/send_email_dialog.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/constant/functions.dart';
import '../../data/model/member.dart';
import '../cubit/salkhana_cubit.dart';
import '../cubit/salkhana_states.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Icon(
                  Icons.email,
                  color: theme.primaryColor,
                  size: 36,
                ),
              ),
              Flexible(
                  child: Text("Emails", style: theme.textTheme.titleLarge)),
            ],
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: MemberTableEmails());
  }
}

// ignore: must_be_immutable
class MemberTableEmails extends StatefulWidget {
  MemberTableEmails({super.key});

  @override
  State<MemberTableEmails> createState() => _MemberTableEmailsState();
}

class _MemberTableEmailsState extends State<MemberTableEmails> {
  var dropdownTitle = "";
  List<SalkhanaMemberModel> selectedMembers = [];

  @override
  Widget build(BuildContext context) {
    items = generateDropdownItems(context);
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<SalkhanaCubit, SalkhanaStates>(
      buildWhen: (previous, current) =>
          current is SalkhanaLoading ||
          current is SalkhanaSuccsses ||
          current is SalkhanaFailureNetwork,
      builder: (context, state) {
        print(state);
        if (state is SalkhanaFailureNetwork) {
          return Center(
            child: Text("Error"),
          );
        } else {
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
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            onPressed: selectedMembers.isNotEmpty
                                ? () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Theme.of(context)
                                            .dialogBackgroundColor,
                                        content: SendEmailDialog(
                                          selectedMembers: selectedMembers,
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            icon: const Icon(Icons.send),
                            label: const Text("Send Emails"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: theme.textTheme.labelSmall,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          width: 1,
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
                            setState(() {
                              dropdownTitle = value!;
                            });
                            BlocProvider.of<SalkhanaCubit>(context)
                                .changeCommittee(value!);
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
                            fit: BoxFit.cover,
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: Text(
                                    "Select",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
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
                                    "Email Sent",
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
        }
      },
    );
  }

  List<DataRow> _buildTableRows(
      BuildContext context, List<SalkhanaMemberModel> members) {
    return members.map((member) {
      final isSelected = selectedMembers.contains(member);
      Color? committee1Color;
      IconData? committee1Icon;
      Color? committee2Color;
      IconData? committee2Icon;

      if (member.resultCommittee1.toLowerCase() == 'accepted') {
        committee1Color = Colors.green;
        committee1Icon = Icons.check_circle;
      } else if (member.resultCommittee1.toLowerCase() == 'rejected') {
        committee1Color = Colors.red;
        committee1Icon = Icons.cancel;
      } else if (member.resultCommittee1.toLowerCase() == 'waiting') {
        committee1Color = Colors.blue;
        committee1Icon = Icons.timer;
      }

      if (member.resultCommittee2.toLowerCase() == 'accepted') {
        committee2Color = Colors.green;
        committee2Icon = Icons.check_circle;
      } else if (member.resultCommittee2.toLowerCase() == 'rejected') {
        committee2Color = Colors.red;
        committee2Icon = Icons.cancel;
      } else if (member.resultCommittee2.toLowerCase() == 'waiting') {
        committee2Color = Colors.blue;
        committee2Icon = Icons.timer;
      }

      return DataRow(
        selected: isSelected,
        onSelectChanged: (bool? selected) {
          setState(() {
            if (selected != null) {
              if (selected) {
                selectedMembers.add(member);
              } else {
                selectedMembers.remove(member);
              }
            }
          });
        },
        cells: [
          DataCell(Center(
              child: Icon(
            isSelected ? Icons.check_box : Icons.check_box_outline_blank,
            color: Theme.of(context).primaryColor,
          ))),
          DataCell(Center(
            child: Text(
              member.name,
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
                  color: committee1Color,
                ),
              ),
              Text(
                member.committee1,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: committee1Color),
              ),
              if (committee1Icon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Icon(committee1Icon, color: committee1Color, size: 16),
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
                  color: committee2Color,
                ),
              ),
              Text(
                member.committee2,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: committee2Color),
              ),
              if (committee2Icon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Icon(committee2Icon, color: committee2Color, size: 16),
                ),
            ],
          ))),
          DataCell(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  member.emailSent ? Icons.check_circle : Icons.cancel,
                  color: member.emailSent ? Colors.green : Colors.red,
                  size: 18,
                ),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    member.emailSent ? 'Sent' : 'Not Sent',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: member.emailSent ? Colors.green : Colors.red,
                        ),
                  ),
                ),
              ],
            ),
          ),
          DataCell(Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PopupMenuButton(
                splashRadius: 25,
                tooltip: "More Actions",
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Theme.of(context).cardColor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'details',
                    child: Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue),
                        SizedBox(width: 10),
                        Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'details') {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor:
                            Theme.of(context).dialogBackgroundColor,
                        title: Text(
                          "Member Details",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        content: Text(
                          "Name: ${member.name}\nPhone: ${member.phone}\nEmail: ${member.email}\nAcademic Year: ${member.academicYear}\nCollege: ${member.college}\nAttendance Date: ${member.attendanceDate}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ))),
        ],
      );
    }).toList();
  }

  List<DropdownMenuItem> generateDropdownItems(BuildContext context) {
    return List.generate(
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
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  late List<DropdownMenuItem> items;

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
        resultCommittee1: index == 0
            ? 'accepted'
            : index == 1
                ? 'rejected'
                : 'waiting',
        resultCommittee2: index == 2
            ? 'accepted'
            : index == 3
                ? 'rejected'
                : 'waiting',
        emailSent: index % 2 == 0),
  ).toList();
}
