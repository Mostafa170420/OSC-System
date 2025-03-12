import 'package:flutter/material.dart';

import '../../data/model/member.dart';

class MemberTable extends StatelessWidget {
  final List<SalkhanaMemberModel> members;
  const MemberTable({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff252728),
                      border: Border.all(color: Colors.grey[600]!, width: 0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: DataTable(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    columnSpacing: isMobile ? 10 : 20,
                    headingTextStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor),
                    columns: [
                      DataColumn(
                          headingRowAlignment: MainAxisAlignment.center,
                          label: Text(
                            "Name",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )),
                      DataColumn(
                          headingRowAlignment: MainAxisAlignment.center,
                          label: Text("Email",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))),
                      DataColumn(
                          headingRowAlignment: MainAxisAlignment.center,
                          label: Text("Phone",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))),
                      if (!isMobile)
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text("Academic Year",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor))),
                      if (!isMobile)
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text("College",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor))),
                      DataColumn(
                          headingRowAlignment: MainAxisAlignment.center,
                          label: Text("Committee 1",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))),
                      DataColumn(
                          headingRowAlignment: MainAxisAlignment.center,
                          label: Text("Committee 2",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))),
                      if (!isMobile)
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text("Committee 1 Result",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor))),
                      if (!isMobile)
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text("Committee 2 Result",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor))),
                      DataColumn(
                          headingRowAlignment: MainAxisAlignment.center,
                          label: Text("Email Sent",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))),
                    ],
                    rows: members.map((member) {
                      return DataRow(cells: [
                        DataCell(
                          Center(
                              child: Text(member.name,
                                  style:
                                      Theme.of(context).textTheme.labelMedium)),
                        ),
                        DataCell(Center(
                            child: Text(
                          member.email,
                          style: Theme.of(context).textTheme.labelMedium,
                        ))),
                        DataCell(Center(
                            child: Text(member.phone,
                                style:
                                    Theme.of(context).textTheme.labelMedium))),
                        if (!isMobile)
                          DataCell(Center(
                              child: Text(member.academicYear,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium))),
                        if (!isMobile)
                          DataCell(Center(
                              child: Text(member.college,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium))),
                        DataCell(Center(child: FlutterLogo())),
                        DataCell(Center(
                          child: Text(member.committee2,
                              style: Theme.of(context).textTheme.labelMedium),
                        )),
                        if (!isMobile)
                          DataCell(Center(
                              child: Text(member.resultCommittee1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium))),
                        if (!isMobile)
                          DataCell(Center(
                              child: Text(member.resultCommittee2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium))),
                        DataCell(Center(
                            child: Text(member.emailSent.toString(),
                                style:
                                    Theme.of(context).textTheme.labelMedium))),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
