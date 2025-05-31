import 'package:badriyya/features/public/gradient_text.dart';
import 'package:badriyya/features/public/more/view/pages/Admission/services/service.dart';
import 'package:badriyya/features/public/more/view/pages/Admission/view/widgets/text_field.dart';
import 'package:flutter/material.dart';

class AdmissionForm extends StatefulWidget {
  const AdmissionForm({super.key});

  @override
  State<AdmissionForm> createState() => _AdmissionFormState();
}

class _AdmissionFormState extends State<AdmissionForm> {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dobController = TextEditingController();
  final ageController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();
  final aadharNumberController = TextEditingController();
  final fatherNameController = TextEditingController();
  final fatherOccupationController = TextEditingController();
  final fatherPhoneNumberController = TextEditingController();
  final motherNameController = TextEditingController();
  final motherOccupationController = TextEditingController();
  final motherPhoneNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    dobController.dispose();
    ageController.dispose();
    stateController.dispose();
    districtController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    aadharNumberController.dispose();
    fatherNameController.dispose();
    fatherOccupationController.dispose();
    fatherPhoneNumberController.dispose();
    motherNameController.dispose();
    motherOccupationController.dispose();
    motherPhoneNumberController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    final name = nameController.text.trim();
    final phonenumber = phoneNumberController.text.trim();
    final dob = dobController.text.trim();
    final age = ageController.text.trim();
    final state = stateController.text.trim();
    final district = districtController.text.trim();
    final city = cityController.text.trim();
    final pincode = pincodeController.text.trim();
    final aadharNumber = aadharNumberController.text.trim();
    final fatherName = fatherNameController.text.trim();
    final fatherOccupation = fatherOccupationController.text.trim();
    final fatherPhoneNumber = fatherPhoneNumberController.text.trim();
    final motherName = motherNameController.text.trim();
    final motherOccupation = motherOccupationController.text.trim();
    final motherPhoneNumber = motherPhoneNumberController.text.trim();

    if ([
      name,
      phonenumber,
      dob,
      age,
      state,
      district,
      city,
      pincode,
      aadharNumber,
      fatherName,
      fatherOccupation,
      fatherPhoneNumber,
      motherName,
      motherOccupation,
      motherPhoneNumber,
    ].any((field) => field.isEmpty)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    // Prepare data to send to backend
    Map<String, String> data = {
      'name': name,
      'phone_number': phonenumber,
      'dob': dob,
      'age': age,
      'state': state,
      'district': district,
      'city': city,
      'pincode': pincode,
      'aadhar_number': aadharNumber,
      'father_name': fatherName,
      'father_occupation': fatherOccupation,
      'father_phone_number': fatherPhoneNumber,
      'mother_name': motherName,
      'mother_occupation': motherOccupation,
      'mother_phone_number': motherPhoneNumber,
    };

    try {
      // Send data to the backend using AdmissionService
      bool success = await AdmissionService.submitAdmissionForm(data);
      if (success) {
        if (mounted) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text("Success 🎉"),
                  content: const Text(
                    "Your form has been sent!\nWe will get back to you soon.",
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
        clearForm();
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

  void clearForm() {
    nameController.clear();
    phoneNumberController.clear();
    dobController.clear();
    ageController.clear();
    stateController.clear();
    districtController.clear();
    cityController.clear();
    pincodeController.clear();
    aadharNumberController.clear();
    fatherNameController.clear();
    fatherOccupationController.clear();
    fatherPhoneNumberController.clear();
    motherNameController.clear();
    motherOccupationController.clear();
    motherPhoneNumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const GradientText("Admission"),
        backgroundColor: Colors.grey[300],
        leading: const BackButton(color: Colors.black),
      ),
      body: Container(
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabel("Student Name"),
              buildTextField(nameController, TextInputType.name),
              buildLabel("Phone Number"),
              buildTextField(phoneNumberController, TextInputType.phone),
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
                        buildTextField(
                          ageController,
                          TextInputType.number,
                          hint: "0",
                        ),
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
                        buildTextField(stateController, TextInputType.name),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabel("District"),
                        buildTextField(districtController, TextInputType.name),
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
                        buildTextField(cityController, TextInputType.name),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabel("Pincode"),
                        buildTextField(
                          pincodeController,
                          TextInputType.number,
                          hint: "000000",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              buildLabel("Aadhar Number"),
              buildTextField(
                aadharNumberController,
                TextInputType.number,
                hint: "**** **** ****",
              ),
              buildLabel("Father Name"),
              buildTextField(fatherNameController, TextInputType.name),
              buildLabel("Occupation"),
              buildTextField(fatherOccupationController, TextInputType.name),
              buildLabel("Phone Number"),
              buildTextField(fatherPhoneNumberController, TextInputType.phone),
              buildLabel("Mother's Name"),
              buildTextField(motherNameController, TextInputType.name),
              buildLabel("Occupation"),
              buildTextField(motherOccupationController, TextInputType.name),
              buildLabel("Phone Number"),
              buildTextField(motherPhoneNumberController, TextInputType.phone),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 5,
                    ),
                    onPressed: submitForm,
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
