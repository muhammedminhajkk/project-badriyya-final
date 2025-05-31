import 'package:badriyya/features/public/dashboard/teachers/model/student_model.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/attendance_adding.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/student_fetching.dart';
import 'package:flutter/material.dart';

class PeriodPeoplePage extends StatefulWidget {
  final String periodName;
  final String classId;
  final int period;

  const PeriodPeoplePage({
    super.key,
    required this.periodName,
    required this.classId,
    required this.period,
  });

  @override
  State<PeriodPeoplePage> createState() => _PeriodPeoplePageState();
}

class _PeriodPeoplePageState extends State<PeriodPeoplePage> {
  List<PersonModel> _people = [];
  final Set<String> _selectedIds = {};
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPeople();
  }

  void _loadPeople() async {
    try {
      final people = await fetchPeople();
      setState(() {
        _people = people;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _onFinishPressed() async {
    final selectedPeople =
        _people.where((p) => _selectedIds.contains(p.id)).toList();
    final userIds = selectedPeople.map((p) => p.id).toList();

    try {
      await submitAttendance(
        classId: widget.classId,
        period: widget.period,
        userIds: userIds,
      );

      // If success, show confirmation dialog
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text("Attendance Updated"),
              content: Text("Marked ${userIds.length} present."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // close dialog
                    Navigator.pop(context); // go back
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
      );
    } catch (e) {
      // Show error dialog
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text("Error"),
              content: Text("Failed to submit attendance:\n$e"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.periodName)),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text("Error: $_error"))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _people.length,
                      itemBuilder: (context, index) {
                        final person = _people[index];
                        final isSelected = _selectedIds.contains(person.id);
                        return CheckboxListTile(
                          value: isSelected,
                          onChanged: (_) => _toggleSelection(person.id),
                          title: Text("${person.firstName} ${person.lastName}"),
                          secondary: CircleAvatar(child: Text("${index + 1}")),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: _selectedIds.isEmpty ? null : _onFinishPressed,
                      child: const Text("Finish"),
                    ),
                  ),
                ],
              ),
    );
  }
}
