import 'package:badriyya/core/navigation%20bar/custom_bottom_navigation_bar.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/teacher_class.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmPage extends StatefulWidget {
  static const String routePath = '/confirm';
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  String input = '';

  void onDigitPressed(String digit) {
    if (input.length < 10) {
      setState(() {
        input += digit;
      });
      if (input == '1234') {
        GoRouter.of(context).go(TeacherClassPage.routePath);
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
      appBar: AppBar(title: const Text('Enter Password')),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                input,
                style: const TextStyle(fontSize: 32, letterSpacing: 8),
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
    );
  }

  Widget _buildKey(String digit) {
    return SizedBox(
      width: 56,
      height: 56,
      child: ElevatedButton(
        onPressed: () => onDigitPressed(digit),
        child: Text(digit, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
