import 'package:badriyya/features/public/dashboard/teachers/model/class_period_model.dart';
import 'package:flutter/material.dart';

class ClassPeriodWidget extends StatelessWidget {
  final ClassPeriodModel model;

  const ClassPeriodWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    const Color standardColor = Colors.blueAccent;
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                    model.subject,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "Period ${model.period}",
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${model.startTime} - ${model.endTime}",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Chip(
            //   label: Text(model.dayOfWeek),
            //   backgroundColor: standardColor.withAlpha(36),
            //   labelStyle: const TextStyle(
            //     color: standardColor,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
