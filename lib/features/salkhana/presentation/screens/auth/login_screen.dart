import 'package:flutter/material.dart';
import 'package:osc_system/features/salkhana/presentation/screens/dashboard_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static final TextEditingController passwordController = TextEditingController();
  static final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.5,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
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
                      ),
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
                    style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: theme.primaryColor),
                      hintText: "Enter your username",
                      filled: true,
                      fillColor: theme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Password",
                    style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                    
                  TextField(
                    controller:passwordController ,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: theme.primaryColor),
                      hintText: "Enter your password",
                      filled: true,
                      fillColor: theme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Implement Forgot Password functionality
                      },
                      child: Text(
                        "Forgot Password?",
                        style: theme.textTheme.labelSmall?.copyWith(color: theme.primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                       if (usernameController.text=='admin'&& passwordController.text=='osc') { // Replace with actual login logic
                          // Navigate to the home screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => DashboardScreen()),
                          );
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
                        style: theme.textTheme.labelSmall?.copyWith(color: Colors.white),
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
                            style: theme.textTheme.labelSmall?.copyWith(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to the Sign-Up screen
                            },
                            child: Text(
                              "Sign Up",
                              style: theme.textTheme.labelSmall?.copyWith(color: theme.primaryColor),
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
    );
  }
}
