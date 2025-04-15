import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:osc_system/core/constant/constant.dart';
import 'package:osc_system/core/constant/functions.dart';

import '../../../../../core/database/hive_helper.dart';
import '../dashboard_screen.dart';
import 'signup_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static final TextEditingController passwordController =
      TextEditingController();
  static final TextEditingController usernameController =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width * 0.35,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.canvasColor.withOpacity(0.8),
                  theme.canvasColor.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Logo(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Login",
                        style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                            fontSize: 32),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Username",
                      style: theme.textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: usernameController,
                      validator: CustomValidator.usernameValidator,
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.person, color: theme.primaryColor),
                        hintText: "Enter your username",
                        filled: true,
                        fillColor: theme.cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Password",
                      style: theme.textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),

                    TextFormField(
                      controller: passwordController,
                      validator: CustomValidator.passwordValidator,
                      obscureText: true,
                      onEditingComplete: () => login(context),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: theme.primaryColor),
                        hintText: "Enter your password",
                        filled: true,
                        fillColor: theme.cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Implement Forgot Password functionality
                        },
                        child: Text(
                          "Forgot Password?",
                          style: theme.textTheme.labelSmall
                              ?.copyWith(color: theme.primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            login(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          "Login",
                          style: theme.textTheme.labelSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Sign Up Link (Optional)
                    Align(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()),
                                );
                                usernameController.clear();
                                passwordController.clear();
                                formKey.currentState?.reset();
                              },
                              child: Text(
                                "Sign Up",
                                style: theme.textTheme.labelSmall
                                    ?.copyWith(color: theme.primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) {
    if (usernameController.text == 'admin' &&
        passwordController.text == 'osc') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
      accountName = usernameController.text;
      usernameController.clear();
      passwordController.clear();
    }

    final username = LoginScreen.usernameController.text.trim();
    final password = LoginScreen.passwordController.text;

    if (HiveHelper.loginAdmin(username, password)) {
      MotionSnackBarSuccess(context, "Login Successful");
      accountName = username;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
      LoginScreen.usernameController.clear();
      LoginScreen.passwordController.clear();
    } else {
      MotionSnackBarError(context, "Invalid username or password");
    }
  }
}
