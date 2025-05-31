import 'package:flutter/material.dart';

import '../model/student.dart';
import '../widgets/student_info_tab.dart';

class StudentInfoPage extends StatefulWidget {
  const StudentInfoPage({Key? key}) : super(key: key);

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage> {
  int selectedTab = 0;
  final Student student = Student(name: 'Kabeer', regNo: 'REG12345');
  final List<String> attendance = ['P', 'A', 'P', 'P', 'R', 'P', 'A'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 44,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      student.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C5364),
                      ),
                    ),
                    Text(
                      student.regNo,
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              StudentInfoTab(
                selectedIndex: selectedTab,
                onTabChanged: (i) => setState(() => selectedTab = i),
              ),
              const SizedBox(height: 22),
              if (selectedTab == 0) ...[
                // Info Page
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 3,
                  color: Colors.white,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 28.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.blueAccent),
                            SizedBox(width: 14),
                            Text(
                              'kabeer@email.com',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 28,
                          thickness: 1.1,
                          color: Color(0xFFF0F0F0),
                        ),
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.green),
                            SizedBox(width: 14),
                            Text(
                              '+1234567890',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 28,
                          thickness: 1.1,
                          color: Color(0xFFF0F0F0),
                        ),
                        Row(
                          children: [
                            Icon(Icons.class_, color: Colors.deepPurple),
                            SizedBox(width: 14),
                            Text(
                              'S7',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 28,
                          thickness: 1.1,
                          color: Color(0xFFF0F0F0),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on, color: Colors.redAccent),
                            SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                '123 Main St, City',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                // Attendance Page
                const Padding(
                  padding: EdgeInsets.only(left: 4.0, bottom: 8),
                  child: Text(
                    'Attendance History',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2C5364),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: 5, // Example: 5 previous days
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final date = '22/05/${25 - index}';
                      final List<String> marks = [
                        'P',
                        'A',
                        'P',
                        'P',
                        'R',
                        'P',
                        'A',
                      ]; // Example data
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: List.generate(marks.length, (i) {
                                  String mark = marks[i];
                                  Color color =
                                      mark == 'P'
                                          ? Colors.green
                                          : mark == 'A'
                                          ? Colors.red
                                          : Colors.orange;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0,
                                    ),
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: color.withAlpha(40),
                                      child: Text(
                                        mark,
                                        style: TextStyle(
                                          color: color,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              Text(
                                date,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
