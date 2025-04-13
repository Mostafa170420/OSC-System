

import 'content.dart';

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
    if (member.resultCommittee1 == 'accepted') accepted++;
    else if (member.resultCommittee1 == 'rejected') rejected++;
    else pending++;

    if (member.resultCommittee2 == 'accepted') accepted++;
    else if (member.resultCommittee2 == 'rejected') rejected++;
    else pending++;
  }

  return ChartStats(
    accepted: accepted,
    rejected: rejected,
    pending: pending,
  );
}

Map<String, ChartStats> calculateCommitteeStats(List<SalkhanaMemberModel> members) {
  final Map<String, ChartStats> result = {};

  for (var committeeName in committees.map((e) => e[0])) {
    int accepted = 0;
    int rejected = 0;
    int pending = 0;

    for (var member in members) {
      if (member.committee1 == committeeName) {
        if (member.resultCommittee1 == 'accepted') accepted++;
        else if (member.resultCommittee1 == 'rejected') rejected++;
        else pending++;
      } else if (member.committee2 == committeeName) {
        if (member.resultCommittee2 == 'accepted') accepted++;
        else if (member.resultCommittee2 == 'rejected') rejected++;
        else pending++;
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
