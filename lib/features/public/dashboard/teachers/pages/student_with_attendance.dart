import 'package:badriyya/features/public/dashboard/teachers/model/student_attendance_model.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/attendance_adding.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/attendance_deleting.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/students_with_attendance_fetching.dart';
import 'package:flutter/material.dart';

class StudentAttendancePage extends StatefulWidget {
  final String classId;
  final String date;
  final int period;
  final String subjectName; // <-- Add this

  const StudentAttendancePage({
    super.key,
    required this.classId,
    required this.date,
    required this.period,
    required this.subjectName, // <-- Add this
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
  String? _removingId;

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

    // If toggling OFF and attendance is not yet saved, just remove locally
    if (isPresent && student.attendance == null) {
      setState(() {
        _presentIds.remove(id);
      });
      return;
    }

    // If toggling OFF and attendance is saved, ask for confirmation
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

      setState(() {
        _removingId = id;
      });

      final success = await deleteAttendance(student.attendance!.id);

      if (!mounted) return;

      setState(() {
        _removingId = null;
        if (success) {
          _presentIds.remove(id);
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? "❌ Attendance removed" : "⚠️ Failed to remove attendance",
          ),
        ),
      );
      return;
    }

    // If toggling ON, just add locally
    setState(() {
      _presentIds.add(id);
    });
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
          appBar: AppBar(
            title: const Text("Mark Attendance"),
            backgroundColor: Colors.teal,
          ),
          body:
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                  ? Center(child: Text("Error: $_error"))
                  : Column(
                    children: [
                      // Header with subject name and date
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Card(
                          color: Colors.teal.shade50,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.subjectName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text("Date: ${widget.date}"),
                                  ],
                                ),
                                const Icon(Icons.class_, color: Colors.teal),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: _students.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final student = _students[index];
                            final isPresent = _presentIds.contains(student.id);
                            final initials =
                                (student.firstName.isNotEmpty
                                    ? student.firstName[0]
                                    : '') +
                                (student.lastName.isNotEmpty
                                    ? student.lastName[0]
                                    : '');
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      isPresent
                                          ? Colors.teal
                                          : Colors.grey.shade300,
                                  child: Text(
                                    initials.toUpperCase(),
                                    style: TextStyle(
                                      color:
                                          isPresent
                                              ? Colors.white
                                              : Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "${student.firstName} ${student.lastName}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isPresent
                                            ? Colors.teal.shade900
                                            : Colors.black87,
                                  ),
                                ),
                                // Removed subtitle (student ID)
                                trailing:
                                    _removingId == student.id
                                        ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                        : Switch(
                                          value: isPresent,
                                          activeColor: Colors.teal,
                                          onChanged:
                                              (_) =>
                                                  _toggle(student.id, student),
                                        ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            onPressed: _saving ? null : _saveAttendance,
                            icon: const Icon(Icons.save),
                            label: const Text(
                              "Save Attendance",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
        ),
        if (_saving)
          Container(
            color: Colors.black.withAlpha((0.3 * 255).toInt()),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
