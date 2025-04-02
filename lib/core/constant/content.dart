

List committees = [
  ["assets/images/icons8-flutter-logo-100.png", "Flutter"],
  ["assets/images/backend-coding.png", "Back-End"],
  ["assets/images/front-end-programming.png", "Front-End"],
  ["assets/images/ui.png", "UI-UX"],
  ["assets/images/linux-tux-svgrepo-com.png", "Linux"],
  ["assets/images/icons8-blender-100.png", "Blender"],
  ["assets/images/all.png", ""]
];

class CustomValidator {
  static String? Function(String?)? validator = (value) {
    if (value!.isEmpty) {
      return "Required";
    }
    return null;
  };
  static String? Function(String?)? emailValidator = (value) {
    if (value!.isEmpty) {
      return "Required";
    }
    if (!(value.contains("@") && value.contains(".com"))) {
      return "Required Email Format";
    }
    return null;
  };
}
