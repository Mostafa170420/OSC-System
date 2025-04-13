import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import '../../../../core/constant/content.dart';
import '../../data/model/member.dart';
import 'custom_text_field.dart';

class SendEmailDialog extends StatelessWidget {
  SendEmailDialog({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final TextEditingController dateController =
        TextEditingController(text: today);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    SalkhanaMemberModel? selectedMember;
    List<SalkhanaMemberModel> selectedMembers = [];

    selectedMember ??= (SalkhanaCubit.get(context).members.isNotEmpty
        ? SalkhanaCubit.get(context).members.first
        : null);

    if (selectedMember != null) {
      emailController.text = selectedMember.email;
      dateController.text = today;
    } else {
      dateController.text = today;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child:
                          Image.asset("assets/images/OSC_logo.png", height: 70),
                    ),
                    Text("Send Email",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 50),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Members",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: DropdownButton<SalkhanaMemberModel>(
                                  isExpanded: true,
                                  value: selectedMember,
                                  iconEnabledColor:
                                      Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                  underline: const SizedBox(),
                                  items: SalkhanaCubit.get(context)
                                      .members
                                      .map((member) {
                                    return DropdownMenuItem(
                                      value: member,
                                      child: Center(child: Text(member.name)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedMember = value;
                                      emailController.text = value?.email ?? '';
                                      dateController.text =
                                          value?.attendanceDate ?? today;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Date",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                              const SizedBox(height: 5),
                              CustomTextField(
                                title: "Send Date",
                                icon: Icons.date_range_rounded,
                                controller: dateController,
                                readOnly: false,
                                validator: CustomValidator.validator,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Select multiple members
                    CustomButton(
                      title: "Select Members",
                      color: Colors.blueGrey,
                      onPressed: () async {
                        final members = SalkhanaCubit.get(context).members;
                        final result = await showModalBottomSheet<
                            List<SalkhanaMemberModel>>(
                          context: context,
                          isScrollControlled: true,
                          builder: (ctx) {
                            List<SalkhanaMemberModel> tempSelected = [
                              ...selectedMembers
                            ];
                            return StatefulBuilder(
                              builder: (ctx, setSheetState) {
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Select Members"),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 300,
                                        child: ListView.builder(
                                          itemCount: members.length,
                                          itemBuilder: (ctx, i) {
                                            final member = members[i];
                                            final isSelected =
                                                tempSelected.contains(member);
                                            return ListTile(
                                              title: Text(member.name),
                                              subtitle: Text(member.email),
                                              trailing: isSelected
                                                  ? const Icon(Icons.check_box)
                                                  : const Icon(Icons
                                                      .check_box_outline_blank),
                                              onTap: () {
                                                setSheetState(() {
                                                  if (isSelected) {
                                                    tempSelected.remove(member);
                                                  } else {
                                                    tempSelected.add(member);
                                                  }
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, tempSelected),
                                        child: const Text("Confirm"),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );

                        if (result != null) {
                          setState(() {
                            selectedMembers = result;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    /// Email
                    CustomTextField(
                      title: "Email",
                      icon: Icons.email,
                      controller: emailController,
                      readOnly: false,
                      validator: CustomValidator.validator,
                    ),

                    const SizedBox(height: 20),

                    /// Email Content
                    CustomTextField(
                      title: "Email Content",
                      icon: Icons.edit,
                      controller: contentController,
                      readOnly: false,
                      validator: CustomValidator.validator,
                      maxLines: 5,
                      alignlableWithHint: true,
                    ),

                    const SizedBox(height: 30),

                    /// Buttons
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        CustomButton(
                          title: "Send to Member",
                          color: const Color(0xff4cb050),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Send email to selectedMember
                              debugPrint("Sending to: ${emailController.text}");
                            }
                          },
                        ),
                        CustomButton(
                          title: "Send to All",
                          color: const Color(0xffed7806),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              for (var member
                                  in SalkhanaCubit.get(context).members) {
                                debugPrint("Sending to: ${member.email}");
                              }
                            }
                          },
                        ),
                        CustomButton(
                          title: "Send to Selected",
                          color: Colors.blue,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (selectedMembers.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("No members selected!"),
                                  ),
                                );
                                return;
                              }
                              for (var member in selectedMembers) {
                                debugPrint("Sending to: ${member.email}");
                              }
                            }
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.color,
    this.onPressed,
  });

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
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
      ),
    );
  }
}
