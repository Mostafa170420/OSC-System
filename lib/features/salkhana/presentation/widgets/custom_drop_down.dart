import 'package:flutter/material.dart';

import '../../../../core/constant/content.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown({super.key, required this.dropdownTitle});
  String dropdownTitle;
  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      iconEnabledColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(20),
      menuWidth: 300,
      value: widget.dropdownTitle,
      items: items,
      underline: SizedBox(),
      onChanged: (value) {
        widget.dropdownTitle = value;
        setState(() {});
      },
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
