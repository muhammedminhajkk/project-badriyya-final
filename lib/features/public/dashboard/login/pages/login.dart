import 'package:badriyya/core/navigation%20bar/custom_bottom_navigation_bar.dart';
import 'package:badriyya/features/public/dashboard/login/widgets/login.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/teacher_class.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatefulWidget {
  static const routePath = '/profile';
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isStudent = false;

  final TextEditingController registerNumberController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    registerNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            left: -80,
            child: Container(
              width: 380,
              height: 380,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color.fromARGB(255, 121, 232, 254), Colors.white],
                  radius: 0.5,
                ),
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 100,
            child: Container(
              width: 380,
              height: 380,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color.fromARGB(255, 121, 232, 254), Colors.white],
                  radius: 0.5,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 100),
                const SizedBox(height: 40),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: registerNumberController,
                  decoration: InputDecoration(
                    labelText: "Register Number",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.blue.shade800],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      final success = await login(
                        registerNumberController.text.trim(),
                        passwordController.text.trim(),
                      );
                      if (success) {
                        GoRouter.of(context).go(TeacherClassPage.routePath);
                      } else {
                        FocusScope.of(context).unfocus(); // Dismiss keyboard
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login failed')),
                        );
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
              child: CustomBottomNavigationBar(currentIndex: 2),
            ),
          ),
        ],
      ),
    );
  }
}
