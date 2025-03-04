import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/home/view/widgets/update_text.dart';
import 'package:project_badriyya/features/public/more/view/widgets/text_field.dart';

class AdmissionForm extends StatelessWidget {
  const AdmissionForm({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final dobController = TextEditingController();
    final ageController = TextEditingController();
    final pincodeController = TextEditingController();
    final aadharNumberController = TextEditingController();
    final fatherNameController = TextEditingController();
    final fatherOccupationController = TextEditingController();
    final fatherPhoneNumberController = TextEditingController();
    final motherNameController = TextEditingController();
    final motherOccupationController = TextEditingController();
    final motherPhoneNumberController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const GradientText("Admission"),
        backgroundColor: Colors.grey[300],
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel("Student Name"),
            buildTextField(nameController),
            buildLabel("Phone Number"),
            buildTextField(phoneNumberController),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel("Date of Birth"),
                      buildDatePickerField(context, dobController),
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
                      buildTextField(ageController),
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
                      const StateDropdown(),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel("District"),
                      const StateDropdown(),
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
                      const StateDropdown(),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel("Pincode"),
                      buildTextField(pincodeController),
                    ],
                  ),
                ),
              ],
            ),
            buildLabel("Aadhar Number"),
            buildTextField(aadharNumberController, hint: "**** **** ****"),
            buildLabel("Father Name"),
            buildTextField(fatherNameController),
            buildLabel("Occupation"),
            buildTextField(fatherOccupationController),
            buildLabel("Phone Number"),
            buildTextField(fatherPhoneNumberController),
            buildLabel("Mother's Name"),
            buildTextField(motherNameController),
            buildLabel("Occupation"),
            buildTextField(motherOccupationController),
            buildLabel("Phone Number"),
            buildTextField(motherPhoneNumberController),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    print(dobController.text);
                  },
                  child: const Text("Submit"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
