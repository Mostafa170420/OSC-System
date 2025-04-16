// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import 'constant.dart';

import '../../features/salkhana/data/model/member.dart';

String committeeImagePath(String name) {
  String path = '';
  for (var element in committees) {
    if (element[1] == name) {
      path = element[0];
      return path;
    }
  }
  return committees[0][0];
}
class ChartStats {
  final int accepted;
  final int rejected;
  final int pending;

  ChartStats({
    required this.accepted,
    required this.rejected,
    required this.pending,
  });
}
  ChartStats calculateOverallStats(List<SalkhanaMemberModel> members) {
    int accepted = 0;
    int rejected = 0;
    int pending = 0;

    for (var member in members) {
      if (member.resultCommittee1.toLowerCase() == 'accepted') {
        accepted++;
      } else if (member.resultCommittee1.toLowerCase() == 'rejected') {
        rejected++;
      } else {
        pending++;
      }
      if (member.resultCommittee2.toLowerCase() == 'accepted') {
        accepted++;
      } else if (member.resultCommittee2.toLowerCase() == 'rejected') {
        rejected++;
      } else {
        pending++;
      }
    }

    return ChartStats(
      accepted: accepted,
      rejected: rejected,
      pending: pending,
    );
  }

  Map<String, ChartStats> calculateCommitteeStats(
      List<SalkhanaMemberModel> members, List<List<String>> committees) {
    final Map<String, ChartStats> result = {};

    for (var committeeName in committees.map((e) => e[0])) {
      int accepted = 0;
      int rejected = 0;
      int pending = 0;

      for (var member in members) {
        if (member.committee1 == committeeName) {
          if (member.resultCommittee1.toLowerCase() == 'accepted')
            accepted++;
          else if (member.resultCommittee1.toLowerCase() == 'rejected')
            rejected++;
          else
            pending++;
        } else if (member.committee2 == committeeName) {
          if (member.resultCommittee2 .toLowerCase()== 'accepted') {
            accepted++;
          } else if (member.resultCommittee2.toLowerCase() == 'rejected')
            rejected++;
          else
            pending++;
        }
      }

      result[committeeName] = ChartStats(
        accepted: accepted,
        rejected: rejected,
        pending: pending,
      );
    }
    return result;
  }

void MotionSnackBarSuccess(BuildContext context, String message) {
  MotionToast.success(
    title: Text(message),
    toastDuration: Duration(seconds: 2),
    toastAlignment: Alignment.bottomRight,
    animationType: AnimationType.slideInFromLeft,
    description: SizedBox(),
    animationDuration: Duration(milliseconds: 400),
    animationCurve: Curves.easeInOut,
    opacity: 0.95,
  ).show(context);
}

void MotionSnackBarError(BuildContext context, String message) {
  MotionToast.error(
    title: Text(message),
    toastDuration: Duration(seconds: 2),
    toastAlignment: Alignment.bottomRight,
    animationType: AnimationType.slideInFromLeft,
    description: SizedBox(),
    animationDuration: Duration(milliseconds: 400),
    animationCurve: Curves.easeInOut,
    opacity: 0.95,
  ).show(context);
}

void MotionSnackBarInfo(BuildContext context, String message) {
  MotionToast.info(
    title: Text(message),
    toastDuration: Duration(seconds: 2),
    toastAlignment: Alignment.bottomRight,
    animationType: AnimationType.slideInFromLeft,
    description: SizedBox(),
    animationDuration: Duration(milliseconds: 400),
    animationCurve: Curves.easeInOut,
    opacity: 0.95,
  ).show(context);
}

void MotionSnackBarWarning(BuildContext context, String message) {
  MotionToast.warning(
    title: Text(message),
    toastDuration: Duration(seconds: 2),
    toastAlignment: Alignment.bottomRight,
    animationType: AnimationType.slideInFromLeft,
    description: SizedBox(),
    animationDuration: Duration(milliseconds: 400),
    animationCurve: Curves.easeInOut,
    opacity: 0.95,
  ).show(context);
}
