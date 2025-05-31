import 'dart:io';

import 'package:badriyya/features/public/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  final String acnumber = "26070200001066";
  final String ifsc = "FDRL0002607";
  final String branch = "FEDERAL BANK, NARIKKUNI";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFe3f2fd),
        title: const GradientText("Donation"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe3f2fd), Color(0xFFbbdefb)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const GradientText("Account Details", size: 28),
                const SizedBox(height: 20),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () async {
                      final status = await Permission.storage.request();

                      if (status.isGranted) {
                        try {
                          // Define the file path in the Downloads folder
                          final directory = Directory(
                            '/storage/emulated/0/Download',
                          );
                          if (!directory.existsSync()) {
                            directory
                                .createSync(); // Create the directory if it doesn't exist
                          }
                          final filePath = "${directory.path}/badriyya_qr.png";

                          // Check if the file already exists
                          final file = File(filePath);
                          if (file.existsSync()) {
                            // Notify the user that the file already exists
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "QR code is already saved at ${file.path}",
                                  ),
                                ),
                              );
                            }
                          }

                          // Load the QR code image from assets
                          final byteData = await rootBundle.load(
                            'assets/qr_icon.png',
                          );
                          final bytes = byteData.buffer.asUint8List();

                          // Write the file to the Downloads folder
                          await file.writeAsBytes(bytes);

                          // Show success message
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("QR code saved to ${file.path}"),
                              ),
                            );
                          }
                        } catch (e) {
                          // Show error message
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Failed to save QR code: $e"),
                              ),
                            );
                          }
                        }
                      } else if (status.isPermanentlyDenied) {
                        // Open app settings if permission is permanently denied
                        openAppSettings();
                      } else {
                        // Show permission denied message
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Storage permission denied"),
                            ),
                          );
                        }
                      }
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 4,
                          right: 6,
                          top: 6,
                          bottom: 4,
                        ),
                        child: Image.asset("assets/qr.png"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                InkWell(
                  onTap: () {
                    Clipboard.setData(
                      const ClipboardData(
                        text: "Badriyya Dars Charitable Trust",
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Name copied to clipboard !"),
                      ),
                    );
                  },
                  child: const GradientText(
                    "Badriyya Dars Charitable Trust",
                    size: 20,
                  ),
                ),

                const SizedBox(height: 24),

                // Account Details
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCopyRow(context, "Account No:", acnumber),
                      const SizedBox(height: 8),
                      _buildCopyRow(context, "IFSC Code:", ifsc),
                      const SizedBox(height: 8),
                      _buildCopyRow(context, "Branch:", branch),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                const Text(
                  "Scan the QR code or use the account details to make a donation.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCopyRow(BuildContext context, String label, String value) {
    return Row(
      children: [
        Text(
          "$label ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: Text(value, style: const TextStyle(color: Colors.black87)),
        ),
        IconButton(
          icon: const Icon(Icons.copy, size: 18, color: Colors.blue),
          tooltip: "Copy $label",
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("$label copied to clipboard !")),
            );
          },
        ),
      ],
    );
  }
}
