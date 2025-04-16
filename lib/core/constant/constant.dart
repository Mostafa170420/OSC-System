import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

List committees = [
  ["assets/images/icons8-flutter-logo-100.png", "Flutter"],
  ["assets/images/backend-coding.png", "Back-End"],
  ["assets/images/front-end-programming.png", "Front-End"],
  ["assets/images/ui.png", "UI-UX"],
  ["assets/images/linux-tux-svgrepo-com.png", "Linux"],
  ["assets/images/icons8-blender-100.png", "Blender"],
  ["assets/images/all.png", ""]
];
String accountName = "";


String accountName = "";

class CustomValidator {
  static String? Function(String?)? passwordValidator = (value) {
  passwordValidator(value) {
    if (value!.isEmpty) {
      return "Required";
    }
    if (value.length < 2) {
      return "Password is too short";
    }
    if (value.length > 20) {
      return "Password is too long";
    }
    // if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$')
    //     .hasMatch(value)) {
    //   return "Password must contain at least one uppercase letter, one lowercase letter, and one number.";
    // }

    return null;
  }
  usernameValidator(value) {
  usernameValidator(value) {
    if (value!.isEmpty) {
      return "Required";
    }
    if (value.length < 3) {
      return "Username is too short";
    }
    if (value.length > 20) {
      return "Username is too long";
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return "Username can only contain letters, numbers, and underscores.";
    }

    return null;
  }
  validator(value) {
    if (value!.isEmpty) {
      return "Required";
    }

    if (value.length > 50) {
      return "Name is too long";
    }

    return null;
  }
  emailValidator(value) {
    if (value!.isEmpty) {
      return "Required";
    }
    if (!(value.contains("@") && value.contains(".com"))) {
      return "Required Email Format";
    }
    if (value.length < 5) {
      return "Email is too short";
    }
    if (value.length > 50) {
      return "Email is too long";
    }


    return null;
  }
 return null;
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Image.asset("assets/images/OSC_logo.png"),
        Shimmer.fromColors(
          enabled: true,
          period: Duration(seconds: 2),
          baseColor: Colors.transparent,
          highlightColor: Colors.white38,
          child: Image.asset("assets/images/OSC_logo.png"),
        ),
      ],
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
 return null;

