import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/salkhana/presentation/widgets/custom_text_field.dart';

import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/constant/functions.dart';
import '../../data/model/member.dart';
import '../cubit/salkhana_cubit.dart';
import '../cubit/salkhana_states.dart';
import '../widgets/add_member_dialog.dart';

// ignore: must_be_immutable
class MembersScreen extends StatelessWidget {
  MembersScreen({super.key});
  var dropdownTitle = "";
  @override
  Widget build(BuildContext context) {
    items = generateDropdownItems(context);
    final theme = Theme.of(context);

    Size size = MediaQuery.of(context).size;
    return BlocListener<SalkhanaCubit, SalkhanaStates>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SalkhanaFailureNetwork) {
          MotionSnackBarError(context, "Check Your NetWork");
        }
      },
      child: BlocBuilder<SalkhanaCubit, SalkhanaStates>(
        buildWhen: (previous, current) =>
            current is SalkhanaLoading ||
            current is SalkhanaSuccsses ||
            current is SalkhanaFailureNetwork,
        builder: (context, state) {
          print(state);
          if (state is SalkhanaFailureNetwork) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.canvasColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "Members",
                            maxLines: 1,
                            style: theme.textTheme.titleLarge
                                ?.copyWith(fontSize: 25),
                          ),
                        ),
                        Flexible(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor:
                                      Theme.of(context).dialogBackgroundColor,
                                  content: AddMemberDialog(
                                    title: "Add New Member",
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.person_add_sharp,
                              size: 24,
                              color: Colors.white,
                            ),
                            label: const Text("add Member"),
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
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                    label: Text(
                                      "Name",
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  DataColumn(
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                    label: Text(
                                      "Phone",
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  DataColumn(
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                    label: Text(
                                      "Email",
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  DataColumn(
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                    label: Text(
                                      "Committee 1",
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  DataColumn(
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                    label: Text(
                                      "Committee 2",
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  DataColumn(
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                    label: Text(
                                      "Attendance",
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  DataColumn(
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                    label: Text(
                                      "Actions",
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
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
      ),
    );
  }

  List<DataRow> _buildTableRows(context, List<SalkhanaMemberModel> members) {
    return members.map((member) {
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
              child: PopupMenuButton(
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
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: committee1Color),
                ),
                if (committee1Icon != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child:
                        Icon(committee1Icon, color: committee1Color, size: 16),
                  ),
              ],
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Accepted',
                child: Row(
                  children: [
                    Icon(Icons.check, color: Colors.green),
                    SizedBox(width: 10),
                    Text(
                      "Accepted",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'Waiting',
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue),
                    SizedBox(width: 10),
                    Text(
                      "Waiting",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'Rejected',
                child: Row(
                  children: [
                    Icon(Icons.cancel, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      "Rejected",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'Accepted') {
                member.resultCommittee1 = "Accepted";
                SalkhanaCubit.get(context).updateMember(member);
              } else if (value == 'Waiting') {
                member.resultCommittee1 = "Waiting";
                SalkhanaCubit.get(context).updateMember(member);
              } else if (value == 'Rejected') {
                final fKey = GlobalKey<FormState>();
                TextEditingController feedback = TextEditingController();
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor:
                              Theme.of(context).dialogBackgroundColor,
                          title: Text(
                            "Rejection Feedback",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          content: Form(
                              key: fKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomTextField(
                                      title: "Feedback",
                                      icon: Icons.feedback,
                                      controller: feedback,
                                      validator: CustomValidator.validator),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      CustomButton(
                                        title: "Cancel",
                                        color: Colors.grey,
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      CustomButton(
                                        title: "Save",
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          if (fKey.currentState!.validate()) {
                                            member.rejectionReasonCommittee1 =
                                                feedback.text;
                                            member.resultCommittee1 =
                                                "Rejected";
                                            SalkhanaCubit.get(context)
                                                .updateMember(member);
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ));
              }
            }, //878787
          ))),
          DataCell(member.committee2.isNotEmpty
              ? Center(
                  child: PopupMenuButton(
                  child: Row(
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
                          child: Icon(committee2Icon,
                              color: committee2Color, size: 16),
                        ),
                    ],
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'Accepted',
                      child: Row(
                        children: [
                          Icon(Icons.check, color: Colors.green),
                          SizedBox(width: 10),
                          Text(
                            "Accepted",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Waiting',
                      child: Row(
                        children: [
                          Icon(Icons.info, color: Colors.blue),
                          SizedBox(width: 10),
                          Text(
                            "Waiting",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Rejected',
                      child: Row(
                        children: [
                          Icon(Icons.cancel, color: Colors.red),
                          SizedBox(width: 10),
                          Text(
                            "Rejected",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'Accepted') {
                      member.resultCommittee2 = "Accepted";
                      SalkhanaCubit.get(context).updateMember(member);
                    } else if (value == 'Waiting') {
                      member.resultCommittee2 = "Waiting";
                      SalkhanaCubit.get(context).updateMember(member);
                    } else if (value == 'Rejected') {
                      final fKey = GlobalKey<FormState>();
                      TextEditingController feedback = TextEditingController();
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                backgroundColor:
                                    Theme.of(context).dialogBackgroundColor,
                                title: Text(
                                  "Rejection Feedback",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                content: Form(
                                    key: fKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomTextField(
                                            title: "Feedback",
                                            icon: Icons.feedback,
                                            controller: feedback,
                                            validator:
                                                CustomValidator.validator),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          children: [
                                            CustomButton(
                                              title: "Cancel",
                                              color: Colors.grey,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            CustomButton(
                                              title: "Save",
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              onPressed: () {
                                                if (fKey.currentState!
                                                    .validate()) {
                                                  member.rejectionReasonCommittee2 =
                                                      feedback.text;
                                                  member.resultCommittee2 =
                                                      "Rejected";
                                                  SalkhanaCubit.get(context)
                                                      .updateMember(member);
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                              ));
                    }
                  }, //878787
                ))
              : SizedBox()),
          DataCell(Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  member.isAttend = !member.isAttend!;

                  BlocProvider.of<SalkhanaCubit>(context).updateMember(member);
                },
                child: !member.isAttend!
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
                splashRadius: 30,
                tooltip: "More Actions",
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Theme.of(context).cardColor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'remove',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 10),
                        Text(
                          "Remove",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'update',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Theme.of(context).primaryColor),
                        SizedBox(width: 10),
                        Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  if (value == 'remove') {
                    showDialog(
                      context: context,
                      barrierDismissible:
                          false, // User must explicitly interact with the dialog
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Theme.of(context)
                              .canvasColor, // Use canvasColor for a cleaner look
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0), // Slightly smaller radius for a modern feel
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons
                                    .warning_amber_rounded, // Use a relevant icon
                                color: Colors.orangeAccent,
                                size: 32.0,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "Confirm Removal",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary, // Use secondary color for emphasis
                                  fontWeight:
                                      FontWeight.w700, // Slightly less bold
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Are you sure you want to remove this member?",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color, // Use appropriate text color
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 24.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      foregroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(width: 12.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<SalkhanaCubit>(context)
                                          .removeMember(member.id);
                                      Navigator.pop(context);
                                      MotionSnackBarSuccess(
                                          context, "Member Removed");
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors
                                          .redAccent, // Use a more prominent color for the destructive action
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 14.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      elevation: 2.0, // Add a subtle shadow
                                    ),
                                    child: Text(
                                      "Remove",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (value == 'update') {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor:
                            Theme.of(context).dialogBackgroundColor,
                        content: AddMemberDialog(
                          title: "Update Member",
                          member: member,
                        ),
                      ),
                    );
                  } else if (value == 'details') {
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
                          "Name: ${member.name}\nPhone: ${member.phone}\nEmail: ${member.email}\nAcademic Year: ${member.academicYear}\nCollege: ${member.college}\nAttendance Date: ${member.attendanceDate}\nAttendance Date 2: ${member.attendanceDate2}",
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
        attendanceDate: "",
        resultCommittee1: "resultCommittee1",
        resultCommittee2: "resultCommittee2",
        attendanceDate2: "",
        emailSent: false),
  ).toList();
}
