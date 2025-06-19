import 'package:badriyya/core/navigation%20bar/custom_bottom_navigation_bar.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/teacher_class.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/teacher_periods.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/class_fetching.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmPage extends StatefulWidget {
  static const String routePath = '/confirm';
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  String input = '';

  void onDigitPressed(String digit) async {
    if (input.length < 10) {
      setState(() {
        input += digit;
      });
      if (input.length == 4) {
        if (input == '1234') {
          final prefs = await SharedPreferences.getInstance();
          final role = prefs.getString('role');
          if (role == 'admin') {
            GoRouter.of(context).go(TeacherClassPage.routePath);
          } else {
            final classlist = await fetchClasses();
            if (classlist.isNotEmpty) {
              GoRouter.of(context).go(TeacherPeriodsPage.routePath);
            } else {
              GoRouter.of(
                context,
              ).go(TeacherPeriodsPage.routePath, extra: {'isMain': false});
            }
          }
        } else {
          // Incorrect PIN
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Incorrect PIN')));
          await Future.delayed(const Duration(milliseconds: 300));
          setState(() {
            input = '';
          });
        }
      }
    }
  }

  void onBackspace() {
    if (input.isNotEmpty) {
      setState(() {
        input = input.substring(0, input.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE0EAFC), Color(0xFFCFDEF3)],
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Enter 4-digit PIN',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    bool filled = index < input.length;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: filled ? Colors.blue : Colors.grey[300],
                        border: Border.all(color: Colors.blue, width: 1.5),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),
                // Improved keypad layout
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var i = 1; i <= 3; i++) _buildKey(i.toString()),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var i = 4; i <= 6; i++) _buildKey(i.toString()),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var i = 7; i <= 9; i++) _buildKey(i.toString()),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Empty space for alignment
                          const SizedBox(width: 56),
                          _buildKey('0'),
                          IconButton(
                            icon: const Icon(Icons.backspace),
                            iconSize: 32,
                            onPressed: onBackspace,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
      ),
    );
  }

  Widget _buildKey(String digit) {
    return SizedBox(
      width: 56,
      height: 56,
      child: ElevatedButton(
        onPressed: () => onDigitPressed(digit),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          elevation: 2,
          side: const BorderSide(color: Colors.blue, width: 1.5),
        ),
        child: Semantics(
          label: 'Digit $digit',
          child: Text(
            digit,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
