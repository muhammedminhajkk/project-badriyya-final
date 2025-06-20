import 'package:badriyya/core/navigation%20bar/custom_bottom_navigation_bar.dart';
import 'package:badriyya/features/public/dashboard/login/widgets/login.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/teacher_class.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/teacher_periods.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/class_fetching.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  static const routePath = '/profile';
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController registerNumberController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    registerNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final regNo = registerNumberController.text.trim();
    final pwd = passwordController.text.trim();

    if (regNo.isEmpty || pwd.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    setState(() => _isLoading = true);
    final success = await login(regNo, pwd);
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      final prefs = await SharedPreferences.getInstance();
      final role = prefs.getString('role');
      if (!mounted) return;
      if (role == 'admin') {
        GoRouter.of(context).go(TeacherClassPage.routePath);
      } else {
        final classlist = await fetchClasses();
        if (!mounted) return;
        if (classlist.isNotEmpty) {
          GoRouter.of(context).go(TeacherPeriodsPage.routePath);
        } else {
          GoRouter.of(
            context,
          ).go(TeacherPeriodsPage.routePath, extra: {'isMain': false});
        }
      }
    } else {
      if (!mounted) return;
      FocusScope.of(context).unfocus(); // Dismiss keyboard
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login failed')));
    }
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
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
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
                    onPressed: _handleLogin,
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
          if (_isLoading)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
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
