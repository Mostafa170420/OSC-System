import 'package:flutter/material.dart';
import 'package:osc_system/core/constant/content.dart';
import 'package:osc_system/features/salkhana/presentation/widgets/custom_text_field.dart';

import 'custom_drop_down.dart';

class AddMemberDialog extends StatelessWidget {
  AddMemberDialog({super.key});
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  var dropdownTitle = "Flutter";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
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
                      title: "Id", icon: Icons.numbers, controller: id)),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: CustomTextField(
                      title: "Name", icon: Icons.person, controller: name))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                      title: "Email", icon: Icons.email, controller: email)),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: CustomTextField(
                      title: "Phone", icon: Icons.phone, controller: phone))
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
                      controller: id)),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: CustomTextField(
                      title: "College", icon: Icons.person, controller: name)),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: CustomTextField(
                      title: "Interview date",
                      icon: Icons.date_range,
                      controller: name))
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
                          child: CustomDropDown(
                            dropdownTitle: dropdownTitle,
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
                          child: CustomDropDown(
                            dropdownTitle: dropdownTitle,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
