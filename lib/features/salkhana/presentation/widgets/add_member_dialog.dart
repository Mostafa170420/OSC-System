import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/core/constant/content.dart';
import 'package:osc_system/features/salkhana/data/model/member.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/drop_down_cubit.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import 'package:osc_system/features/salkhana/presentation/widgets/custom_text_field.dart';

class AddMemberDialog extends StatelessWidget {
  AddMemberDialog({super.key, this.member});
  final SalkhanaMemberModel? member;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? committee1 = (member == null) ? null : member!.committee1;
    String? committee2 = (member == null) ? null : member!.committee2;
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
    return BlocProvider(
      create: (context) => DropDownCubit(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Image.asset(
                    "assets/images/OSC_logo.png",
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "Add New Member",
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
                      readOnly: true,
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
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: CustomTextField(
                            title: "Interview Date",
                            icon: Icons.date_range,
                            controller: interviewDate,
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
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: BlocBuilder<DropDownCubit, int>(
                                  builder: (context, state) {
                                    return DropdownButton(
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
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: BlocBuilder<DropDownCubit, int>(
                                  builder: (context, state) {
                                    return DropdownButton(
                                      isExpanded: true,
                                      iconEnabledColor:
                                          Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                      menuWidth: 300,
                                      value: committee2,
                                      items: items,
                                      underline: SizedBox(),
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
                                      attendanceDate: "a",
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
                                      attendanceDate: "",
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
    );
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
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.title, required this.color, this.onPressed});
  final String title;
  final Color color;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 60,
      minWidth: 300,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Text(
        overflow: TextOverflow.clip,
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
      ),
    );
  }
}
