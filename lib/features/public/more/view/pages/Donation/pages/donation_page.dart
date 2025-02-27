import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/home/view/widgets/update_text.dart';

class Donation extends StatelessWidget {
  const Donation({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: const GradientText("Dontaion")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount Card
            Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        hintText: "0",
                        border: InputBorder.none, // Remove default underline
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "Notes",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Input Fields
            _buildTextField("Name", true),
            _buildTextField("Place", true),
            _buildTextField("Phone Number", true),

            const SizedBox(height: 20),

            // Pay Button
            Center(
              child: _buildButton("Pay", Colors.teal, Colors.white,
                  gradient: true),
            ),
          ],
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
    return Container(
      width: double.infinity,
      height: 50,
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
    );
  }
}
