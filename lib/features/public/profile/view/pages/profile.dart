import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/home/view/widgets/custom_bottom_navigation_bar.dart';

class Profile extends StatelessWidget {
  static const routePath = '/profile';

  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Student",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Teacher",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 2,
                      width: 60,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      height: 2,
                      width: 60,
                      color: Colors.white,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Profile Image
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey[300],
                    child:
                        const Icon(Icons.person, size: 100, color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 20),

                // Register Number TextField
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Register Number",
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),

                // Password TextField
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Password",
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),

                // Remember Me & Forgot Password Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        const Text("Remember me"),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Forgot Password?"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Login Button
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    // color: gradient ? null : color,
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                        colors: [Colors.teal, Colors.blue.shade900]),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Login",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          const Column(
            children: [
              Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
                child: CustomBottomNavigationBar(currentIndex: 2),
              ),
            ],
          )
        ],
      ),
    );
  }
}
