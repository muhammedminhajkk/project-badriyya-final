import 'package:badriyya/features/public/gradient_text.dart';
import 'package:badriyya/features/public/more/view/pages/Enquiry/services/senddata.dart';
import 'package:badriyya/features/public/more/view/pages/Enquiry/view/widgets/buttons_and_fields.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Enquiry extends StatefulWidget {
  const Enquiry({super.key});

  @override
  State<Enquiry> createState() => _EnquiryState();
}

class _EnquiryState extends State<Enquiry> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  Future<void> _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> submitForm() async {
    final name = nameController.text.trim();
    final email = mobileNumberController.text.trim();
    final message = subjectController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
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
      'email': email,
      'message': message,
    };

    try {
      // Send data to the backend using EnquiryService
      bool success = await EnquiryService.sendEnquiry(data);
      if (success) {
        if (mounted) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text("Success 🎉"),
                  content: const Text(
                    "Your enquiry has been sent!\nWe will get back to you soon.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
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
          mobileNumberController.clear();
          subjectController.clear();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to send enquiry')),
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
    mobileNumberController.dispose();
    subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const GradientText("Enquiry"),
      ),
      body: Container(
        width: double.infinity,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildButton(
                      icon: Icons.chat,
                      label: "WhatsApp",
                      color: Colors.green,
                      onPressed:
                          () => _launchURL(
                            Uri.parse("https://wa.me/918606728003"),
                          ),
                    ),
                    buildButton(
                      icon: Icons.mail,
                      label: "Inbox",
                      color: Colors.orange,
                      onPressed:
                          () => _launchURL(
                            Uri.parse(
                              'mailto:Badriyyanediyanad@gmail.com?subject=Enquiry&body=Message',
                            ),
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildButton(
                      icon: Icons.call,
                      label: "Contact",
                      color: Colors.blue,
                      onPressed:
                          () => _launchURL(Uri.parse("tel:+918606728003")),
                    ),
                    buildButton(
                      icon: Icons.location_on,
                      label: "Location",
                      color: Colors.black87,
                      onPressed:
                          () => _launchURL(
                            Uri.parse(
                              "https://maps.app.goo.gl/psNc6TGRgkeFjkaP9",
                            ),
                          ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Form Fields
                buildField("Name", nameController),
                buildField("Mobile Number", mobileNumberController),
                buildField("Subject", subjectController),

                const SizedBox(height: 20),

                // Send Button
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: submitForm,
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
                              Text(
                                "Send",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.send, size: 18, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
