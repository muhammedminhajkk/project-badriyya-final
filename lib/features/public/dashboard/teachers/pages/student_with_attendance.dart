import 'package:badriyya/features/public/dashboard/teachers/model/student_attendance_model.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/attendance_adding.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/attendance_deleting.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/students_with_attendance_fetching.dart';
import 'package:flutter/material.dart';

class StudentAttendancePage extends StatefulWidget {
  final String classId;
  final String date;
  final int period;

  const StudentAttendancePage({
    super.key,
    required this.classId,
    required this.date,
    required this.period,
  });

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  List<StudentAttendanceModel> _students = [];
  Set<String> _presentIds = {};
  bool _loading = true;
  String? _error;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final students = await fetchStudentAttendance(
        classId: widget.classId,
        date: widget.date,
        period: widget.period,
      );
      if (!mounted) return;
      setState(() {
        _students = students;
        _presentIds =
            students
                .where((s) => s.attendance != null)
                .map((s) => s.id)
                .toSet();
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _toggle(String id, StudentAttendanceModel student) async {
    final isPresent = _presentIds.contains(id);
    if (isPresent && student.attendance != null) {
      final confirm = await showDialog<bool>(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text("Remove Attendance"),
              content: const Text(
                "Are you sure you want to unmark attendance?",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Confirm"),
                ),
              ],
            ),
      );
      if (confirm != true) return;
      final success = await deleteAttendance(student.attendance!.id);
      if (success) {
        setState(() {
          _presentIds.remove(id);
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("❌ Attendance removed")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("⚠️ Failed to remove attendance")),
        );
      }
    } else {
      setState(() {
        _presentIds.add(id);
      });
    }
  }

  Future<void> _saveAttendance() async {
    final userIdsToUpdate =
        _students
            .where((s) => _presentIds.contains(s.id) && s.attendance == null)
            .map((s) => s.id)
            .toList();

    if (userIdsToUpdate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ All selected students already marked")),
      );
      return;
    }

    setState(() {
      _saving = true;
    });

    final success = await updateAttendance(
      classId: widget.classId,
      date: widget.date,
      period: widget.period,
      userIds: userIdsToUpdate,
    );

    if (!mounted) return;

    setState(() {
      _saving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? "✅ Attendance updated" : "❌ Update failed"),
      ),
    );

    if (success) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text("Mark Attendance")),
          body:
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                  ? Center(child: Text("Error: $_error"))
                  : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _students.length,
                          itemBuilder: (context, index) {
                            final student = _students[index];
                            final isPresent = _presentIds.contains(student.id);
                            return ListTile(
                              title: Text(
                                "${student.firstName} ${student.lastName}",
                              ),
                              subtitle: Text("ID: ${student.studentId}"),
                              trailing: Switch(
                                value: isPresent,
                                onChanged: (_) => _toggle(student.id, student),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: _saving ? null : _saveAttendance,
                          child: const Text("Save Attendance"),
                        ),
                      ),
                    ],
                  ),
        ),
        if (_saving)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
