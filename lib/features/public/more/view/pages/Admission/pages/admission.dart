import 'package:flutter/material.dart';

class AdmissionForm extends StatelessWidget {
  const AdmissionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Admission",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        backgroundColor: Colors.grey[300],
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel("Student Name"),
            buildTextField(),
            buildLabel("Phone Number"),
            buildTextField(),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel("Date of Birth"),
                      buildTextField(),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel("Age"),
                      buildTextField(),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel("State *"),
                      buildDropdownButton(),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel("District"),
                      buildDropdownButton(),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel("City"),
                      buildDropdownButton(),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel("Pincode"),
                      buildTextField(),
                    ],
                  ),
                ),
              ],
            ),
            buildLabel("Aadhar Number"),
            buildTextField(),
            buildLabel("Father Name"),
            buildTextField(),
            buildLabel("Occupation"),
            buildTextField(),
            buildLabel("Phone Number"),
            buildTextField(),
            buildLabel("Mother's Name"),
            buildTextField(),
            buildLabel("Occupation"),
            buildTextField(),
            buildLabel("Phone Number"),
            buildTextField(),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildTextField() {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget buildDropdownButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: null,
          hint: const Text("Select Place"),
          items: <String>["Option 1", "Option 2", "Option 3"]
              .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
