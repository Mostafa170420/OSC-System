import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/constant/constant.dart';
import '../../data/model/member.dart';
import '../cubit/drop_down_cubit.dart';
import '../cubit/salkhana_cubit.dart';
import 'custom_text_field.dart';

class AddMemberDialog extends StatelessWidget {
  AddMemberDialog({super.key, this.member, required this.title});
  String title;
  final SalkhanaMemberModel? member;
  final formKey = GlobalKey<FormState>();
  String? committee1;
  String? committee2;
  String? setCommittee(SalkhanaMemberModel? memberModel) {
    if (memberModel == null) {
      return null;
    }
    if (memberModel.committee2.isEmpty) {
      return null;
    } else {
      return memberModel.committee2;
    }
  }

  @override
  Widget build(BuildContext context) {
    committee1 = (member == null) ? null : member!.committee1;
    committee2 = setCommittee(member);
    final TextEditingController id =
        TextEditingController(text: (member == null) ? "" : member!.id);
    final TextEditingController name =
        TextEditingController(text: (member == null) ? "" : member!.name);
    final TextEditingController email =
        TextEditingController(text: (member == null) ? "" : member!.email);
    final TextEditingController phone =
        TextEditingController(text: (member == null) ? "" : member!.phone);
    final TextEditingController academicYear = TextEditingController(
        text: (member == null) ? "" : member!.academicYear);
    final TextEditingController college =
        TextEditingController(text: (member == null) ? "" : member!.college);
    final TextEditingController interviewDate = TextEditingController(
        text: (member == null) ? "" : member!.attendanceDate);
    final TextEditingController interviewDate2 = TextEditingController(
        text: (member == null) ? "" : member!.attendanceDate2);
    final List<DropdownMenuItem> items = generateItems(context);
    return BlocProvider(
      create: (context) => DropDownCubit(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 200),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(height: 100, width: 100, child: Logo()),
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextField(
                        title: "Id",
                        icon: Icons.numbers,
                        controller: id,
                        readOnly: (member == null) ? false : true,
                        validator: CustomValidator.validator,
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: CustomTextField(
                              title: "Name",
                              icon: Icons.person,
                              controller: name,
                              validator: CustomValidator.validator))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextField(
                              title: "Email",
                              icon: Icons.email,
                              controller: email,
                              validator: CustomValidator.emailValidator)),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: CustomTextField(
                              title: "Phone",
                              icon: Icons.phone,
                              controller: phone,
                              validator: CustomValidator.validator))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextField(
                              title: "Academic Year",
                              icon: Icons.numbers,
                              controller: academicYear,
                              validator: CustomValidator.validator)),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: CustomTextField(
                              title: "College",
                              icon: Icons.home_work,
                              controller: college,
                              validator: CustomValidator.validator)),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextField(
                              title: "Interview Date 1",
                              icon: Icons.date_range,
                              controller: interviewDate,
                              validator: CustomValidator.validator)),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: CustomTextField(
                              title: "Interview Date 2",
                              icon: Icons.date_range,
                              controller: interviewDate2,
                              validator: CustomValidator.validator))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                            width: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Committee 1",
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: BlocBuilder<DropDownCubit, int>(
                                    builder: (context, state) {
                                      return DropdownButton(
                                        dropdownColor:
                                            Theme.of(context).cardColor,
                                        isExpanded: true,
                                        iconEnabledColor:
                                            Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                        menuWidth: 300,
                                        value: committee1,
                                        items: items,
                                        underline: SizedBox(),
                                        onChanged: (value) {
                                          committee1 = value;
                                          DropDownCubit.get(context)
                                              .changeState(0);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: SizedBox(
                            width: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Committee 2",
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: BlocBuilder<DropDownCubit, int>(
                                    builder: (context, state) {
                                      return DropdownButton(
                                        underline: SizedBox(),
                                        dropdownColor:
                                            Theme.of(context).cardColor,
                                        isExpanded: true,
                                        iconEnabledColor:
                                            Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                        menuWidth: 300,
                                        value: committee2,
                                        items: items,
                                        onChanged: (value) {
                                          committee2 = value;
                                          DropDownCubit.get(context)
                                              .changeState(1);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: CustomButton(
                          title: "Save & Attend",
                          color: Color(0xff4cb050),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (committee1 == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Take at least 1 committee")));
                              } else {
                                SalkhanaCubit.get(context).addMember(
                                    SalkhanaMemberModel(
                                        id: id.text,
                                        name: name.text,
                                        email: email.text,
                                        phone: phone.text,
                                        academicYear: academicYear.text,
                                        college: college.text,
                                        committee1: committee1!,
                                        committee2: committee2 ?? "",
                                        resultCommittee1: "",
                                        resultCommittee2: "",
                                        attendanceDate: interviewDate.text,
                                        attendanceDate2: interviewDate2.text,
                                        isAttend: true,
                                        emailSent: false));
                                Navigator.pop(context);
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: CustomButton(
                          title: "Save",
                          color: Color(0xffed7806),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (committee1 == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Take at lest 1 commttee")));
                              } else {
                                SalkhanaCubit.get(context).addMember(
                                    SalkhanaMemberModel(
                                        id: id.text,
                                        name: name.text,
                                        email: email.text,
                                        phone: phone.text,
                                        academicYear: academicYear.text,
                                        college: college.text,
                                        committee1: committee1!,
                                        committee2: committee2 ?? "",
                                        resultCommittee1: "",
                                        resultCommittee2: "",
                                        attendanceDate: interviewDate.text,
                                        attendanceDate2: interviewDate2.text,
                                        isAttend: false,
                                        emailSent: false));
                                Navigator.pop(context);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> generateItems(BuildContext context) {
    return List.generate(
      committees.length - 1,
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
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
