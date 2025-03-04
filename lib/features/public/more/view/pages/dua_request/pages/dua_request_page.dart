import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/home/view/widgets/update_text.dart';

class DuaRequest extends StatelessWidget {
  const DuaRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const GradientText("Dua Request"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text Area

              const SizedBox(
                height: 100,
              ),
              const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Write Here...",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 16),

              // Input Fields
              _buildTextField("Name", true),
              _buildTextField("Place", true),
              _buildTextField("Phone Number", true),

              const SizedBox(height: 20),

              // Skip & Submit Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton("Skip", Colors.grey, Colors.black),
                  _buildButton("Submit", Colors.teal, Colors.white,
                      gradient: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Text Field Widget
  Widget _buildTextField(String label, bool isRequired) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              children: isRequired
                  ? [
                      const TextSpan(
                          text: " *", style: TextStyle(color: Colors.red))
                    ]
                  : [],
            ),
          ),
          const SizedBox(height: 4),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  // Custom Button Widget
  Widget _buildButton(String label, Color color, Color textColor,
      {bool gradient = false}) {
    return Expanded(
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: gradient ? null : color,
          borderRadius: BorderRadius.circular(8),
          gradient: gradient
              ? LinearGradient(colors: [Colors.teal, Colors.blue.shade900])
              : null,
        ),
        child: TextButton(
          onPressed: () {},
          child: Text(label, style: TextStyle(color: textColor, fontSize: 16)),
        ),
      ),
    );
  }
}
