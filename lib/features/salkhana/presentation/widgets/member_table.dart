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
          child: DataTable(
            columnSpacing: isMobile ? 10 : 20,
            columns: [
              DataColumn(label: Text("Name",style: TextStyle(color: Theme.of(context).primaryColor),)),
              DataColumn(label: Text("Email",style: TextStyle(color: Theme.of(context).primaryColor))),
              DataColumn(label: Text("Phone",style: TextStyle(color: Theme.of(context).primaryColor))),
              if (!isMobile) DataColumn(label: Text("Academic Year",style: TextStyle(color: Theme.of(context).primaryColor))),
              if (!isMobile) DataColumn(label: Text("College",style: TextStyle(color: Theme.of(context).primaryColor))),
              DataColumn(label: Text("Committee 1",style: TextStyle(color: Theme.of(context).primaryColor))),
              DataColumn(label: Text("Committee 2",style: TextStyle(color: Theme.of(context).primaryColor))),
              if (!isMobile) DataColumn(label: Text("Committee 1 Result",style: TextStyle(color: Theme.of(context).primaryColor))),
              if (!isMobile) DataColumn(label: Text("Committee 2 Result",style: TextStyle(color: Theme.of(context).primaryColor))),
              DataColumn(label: Text("Email Sent",style: TextStyle(color: Theme.of(context).primaryColor))),
            ],
            rows: members.map((member) {
              return DataRow(

                cells: [
                DataCell(Text(member.name)),
                DataCell(Text(member.email)),
                DataCell(Text(member.phone)),
                if (!isMobile) DataCell(Text(member.academicYear)),
                if (!isMobile) DataCell(Text(member.college)),
                DataCell(Text(member.committee1)),
                DataCell(Text(member.committee2)),
                if (!isMobile) DataCell(Text(member.resultCommittee1)),
                if (!isMobile) DataCell(Text(member.resultCommittee2)),
                DataCell(Text(member.emailSent.toString())),
              ]);
            }).toList(),
          ),
        );
      },
    );
  }
}