import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'content.dart';

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
