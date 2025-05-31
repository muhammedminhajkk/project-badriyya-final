import 'package:flutter/material.dart';

class PeriodCard extends StatelessWidget {
  final String subject;
  final String hour;
  final String time;
  final String section;
  const PeriodCard({
    Key? key,
    required this.subject,
    required this.hour,
    required this.time,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color standardColor = Colors.blueAccent;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: standardColor.withAlpha(36),
              radius: 28,
              child: const Icon(Icons.book, color: standardColor, size: 28),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(hour, style: const TextStyle(fontSize: 15)),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(time, style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
            Chip(
              label: Text(section),
              backgroundColor: standardColor.withAlpha(36),
              labelStyle: const TextStyle(
                color: standardColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
