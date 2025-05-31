import 'package:badriyya/features/public/gradient_text.dart';
import 'package:badriyya/features/public/more/view/pages/dua_request/service/dua_service.dart';
import 'package:flutter/material.dart';

class DuaRequest extends StatefulWidget {
  const DuaRequest({super.key});

  @override
  State<DuaRequest> createState() => _DuaRequestState();
}

class _DuaRequestState extends State<DuaRequest> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  Future<void> submitDuaForm() async {
    final name = nameController.text.trim();
    final place = placeController.text.trim();
    final phone = phoneController.text.trim();
    final message = messageController.text.trim();

    if (name.isEmpty || place.isEmpty || phone.isEmpty || message.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      }
      return;
    }

    // Prepare data to send to backend
    Map<String, String> data = {
      'name': name,
      'place': place,
      'phone': phone,
      'message': message,
    };

    try {
      // Send data to the backend using DuaService
      bool success = await DuaService.sendDuaRequest(data);
      if (success) {
        if (mounted) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text("Success 🎉"),
                  content: const Text(
                    "Your Dua request has been submitted!\nWe will pray for you.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
          );
        }

        // Clear form after successful submission
        if (mounted) {
          nameController.clear();
          placeController.clear();
          phoneController.clear();
          messageController.clear();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to submit request')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Error while submitting')));
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    placeController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const GradientText("Dua Request"),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 252, 254, 255),
              Color.fromARGB(255, 161, 217, 255),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text Area for Message
                const SizedBox(height: 100),
                TextField(
                  controller: messageController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Write Here...",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 16),

                // Input Fields
                _buildTextField("Name", nameController, true),
                _buildTextField("Place", placeController, true),
                _buildTextField("Phone Number", phoneController, true),

                const SizedBox(height: 20),

                // Skip & Submit Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildButton(
                      "Submit",
                      Colors.teal,
                      Colors.white,
                      onPressed: submitDuaForm,
                      gradient: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom Text Field Widget
  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isRequired,
  ) {
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
                color: Colors.black,
              ),
              children:
                  isRequired
                      ? [
                        const TextSpan(
                          text: " *",
                          style: TextStyle(color: Colors.red),
                        ),
                      ]
                      : [],
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            keyboardType:
                label == "Phone Number"
                    ? TextInputType.phone
                    : TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom Button Widget
  Widget _buildButton(
    String label,
    Color color,
    Color textColor, {
    bool gradient = false,
    VoidCallback? onPressed,
  }) {
    return Expanded(
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: gradient ? null : color,
          borderRadius: BorderRadius.circular(8),
          gradient:
              gradient
                  ? LinearGradient(colors: [Colors.teal, Colors.blue.shade900])
                  : null,
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(label, style: TextStyle(color: textColor, fontSize: 16)),
        ),
      ),
    );
  }
}
