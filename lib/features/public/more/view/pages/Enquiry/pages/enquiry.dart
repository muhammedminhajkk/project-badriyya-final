import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/home/view/widgets/update_text.dart';

class Enquiry extends StatelessWidget {
  const Enquiry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const GradientText("Enquiry"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(Icons.mail, "Whatsapp", Colors.green),
                _buildButton(Icons.mail, "Inbox", Colors.orange),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(Icons.person, "Contact", Colors.purple),
                _buildButton(Icons.location_on, "Location", Colors.black87),
              ],
            ),
            const SizedBox(height: 20),

            // Form Fields
            _buildTextField("Name"),
            _buildTextField("Mobile Number"),
            _buildTextField("Name"),

            const SizedBox(height: 20),

            // Send Button
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal, Colors.blue.shade900],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Send",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          SizedBox(width: 8),
                          Icon(
                            Icons.send,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Button Widget
  Widget _buildButton(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton.icon(
          onPressed: () {},
          icon: Icon(icon, color: Colors.white),
          label: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }

  // Custom Text Field Widget
  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
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
}
