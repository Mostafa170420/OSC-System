import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:osc_system/core/constant/functions.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import '../../../../core/constant/constant.dart';
import '../../data/model/member.dart';
import 'custom_text_field.dart';

class SendEmailDialog extends StatelessWidget {
  final List<SalkhanaMemberModel> selectedMembers;
  final TextEditingController dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final SalkhanaMemberModel? initialSingleMember;

  SendEmailDialog({
    super.key,
    required this.selectedMembers,
    SalkhanaMemberModel? initialSingleMemberParam,
  }) : initialSingleMember = initialSingleMemberParam {
    if (selectedMembers.isNotEmpty) {
      emailController.text = selectedMembers.first.email;
    } else if (initialSingleMember != null) {
      emailController.text = initialSingleMember!.email;
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(height: 100, width: 100, child: Logo()),
                ),
                Text("Send Email", style: theme.textTheme.titleLarge),
                const SizedBox(height: 20),

                if (selectedMembers.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selected Members:",
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 10),
                        DataTable(
                          columnSpacing: 20,
                          columns: [
                            DataColumn(
                                headingRowAlignment: MainAxisAlignment.center,
                                label: Text(
                                  'Name',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            DataColumn(
                                headingRowAlignment: MainAxisAlignment.center,
                                label: Text(
                                  'Email',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Flexible(
                                child: Text(
                                  'C 1 Status',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Flexible(
                                child: Text(
                                  'C 2 Status',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          rows: selectedMembers
                              .map((member) => DataRow(cells: [
                                    DataCell(Center(
                                      child: Text(
                                        member.name,
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: Text(
                                        member.email,
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          _getStatusText(
                                              member.resultCommittee1),
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: _getStatusColor(
                                                member.resultCommittee1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          _getStatusText(
                                              member.resultCommittee2),
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: _getStatusColor(
                                                member.resultCommittee2),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]))
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                else if (initialSingleMember != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Member:",
                          style: theme.textTheme.labelSmall,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(initialSingleMember!.name),
                            Text(
                              initialSingleMember!.email,
                              style: theme.textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Committee 1 Status: ${_getStatusText(initialSingleMember!.resultCommittee1)}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                  color: _getStatusColor(
                                      initialSingleMember!.resultCommittee1)),
                            ),
                            Text(
                              "Committee 2 Status: ${_getStatusText(initialSingleMember!.resultCommittee2)}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                  color: _getStatusColor(
                                      initialSingleMember!.resultCommittee2)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),

                const SizedBox(height: 20),

                /// Email
                CustomTextField(
                  title: "Email",
                  icon: Icons.email,
                  controller: emailController,
                  readOnly: true,
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
                    if (selectedMembers.isEmpty && initialSingleMember != null)
                      CustomButton(
                        title: "Send to Member",
                        color: const Color(0xff4cb050),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            debugPrint("Sending to: ${emailController.text}");
                            debugPrint("Content: ${contentController.text}");
                            debugPrint("Date: ${dateController.text}");
                            // Implement sending logic
                          }
                        },
                      ),
                    if (SalkhanaCubit.get(context).members.isNotEmpty &&
                        selectedMembers.isEmpty &&
                        initialSingleMember == null)
                      CustomButton(
                        title: "Send to All",
                        color: const Color(0xffed7806),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
                        },
                      ),
                    if (selectedMembers.isNotEmpty)
                      CustomButton(
                        title: "Send to Selected (${selectedMembers.length})",
                        color: theme.primaryColor,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<SalkhanaCubit>(context)
                                .sendEmail(selectedMembers);
                          }
                        },
                      ),
                    CustomButton(
                      title: "Cancel",
                      color: Colors.red,
                      onPressed: () {
                        // Close the dialog
                        selectedMembers.clear();
                        emailController.clear();
                        contentController.clear();
                        dateController.clear();
                        formKey.currentState?.reset();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'accepted':
        return 'Accepted';
      case 'rejected':
        return 'Rejected';
      default:
        return 'Waiting';
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
