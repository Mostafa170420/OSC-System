import 'package:flutter/material.dart';
import 'package:osc_system/core/constant/constant.dart';
import 'package:osc_system/core/constant/functions.dart';

import '../../../../../core/database/hive_helper.dart';
import '../dashboard_screen.dart';
import 'login_screen.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  static final TextEditingController usernameController =
      TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();
  static final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
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
                        "Sign Up",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Username
                    Text("Username",
                        style: theme.textTheme.labelMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: usernameController,
                      validator: CustomValidator.usernameValidator,
                      decoration: _buildInputDecoration(
                          theme, "Enter your username", Icons.person),
                    ),
                    const SizedBox(height: 20),

                    // Password
                    Text("Password",
                        style: theme.textTheme.labelMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      validator: CustomValidator.passwordValidator,
                      obscureText: true,
                      decoration: _buildInputDecoration(
                          theme, "Enter your password", Icons.lock),
                    ),
                    const SizedBox(height: 20),

                    // Confirm Password
                    Text("Confirm Password",
                        style: theme.textTheme.labelMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: _buildInputDecoration(
                          theme, "Re-enter your password", Icons.lock),
                    ),

                    const SizedBox(height: 30),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            signUp(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text("Sign Up",
                            style: theme.textTheme.labelSmall
                                ?.copyWith(color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Login Link
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text("Already have an account? ",
                                style: theme.textTheme.labelSmall
                                    ?.copyWith(color: Colors.grey)),
                          ),
                          Flexible(
                            child: TextButton(
                              onPressed: () {
                                usernameController.clear();
                                passwordController.clear();
                                confirmPasswordController.clear();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              child: Text("Login",
                                  style: theme.textTheme.labelSmall
                                      ?.copyWith(color: theme.primaryColor)),
                            ),
                          ),
                        ],
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

  InputDecoration _buildInputDecoration(
      ThemeData theme, String hintText, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: theme.primaryColor),
      hintText: hintText,
      filled: true,
      fillColor: theme.cardColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }

  void signUp(BuildContext context)async {
   final username = SignUpScreen.usernameController.text.trim();
  final password = SignUpScreen.passwordController.text;
  final confirmPassword = SignUpScreen.confirmPasswordController.text;

  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Passwords do not match")),
    );
    return;
  }

  try {
    await HiveHelper.registerAdmin(username, password);
    MotionSnackBarInfo(context, 
        "Admin registered successfully. You can now log in.");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  } catch (e) {
    MotionSnackBarError(context, 
        "Error: ${e.toString()}");

  }
  }
}
