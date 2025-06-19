import 'package:flutter/material.dart';

class MorningAndEveningAttendanceCard extends StatelessWidget {
  final String title;
  final Color startColor;
  final Color endColor;
  final Color iconColor;
  final Color avatarBgColor;
  final Color textColor;
  final IconData icon;
  final VoidCallback onTap;

  const MorningAndEveningAttendanceCard({
    super.key,
    required this.title,
    required this.startColor,
    required this.endColor,
    required this.iconColor,
    required this.avatarBgColor,
    required this.textColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [startColor, endColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: startColor.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 18),
              CircleAvatar(
                radius: 28,
                backgroundColor: avatarBgColor,
                child: Icon(icon, color: iconColor, size: 32),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: iconColor),
              const SizedBox(width: 18),
            ],
          ),
        ),
      ),
    );
  }
}
