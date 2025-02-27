import 'package:flutter/material.dart';

Widget buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 12.0, bottom: 4),
    child: Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    ),
  );
}

Widget buildTextField(TextEditingController ctrlr) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextField(
      controller: ctrlr,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    ),
  );
}

class StateDropdown extends StatefulWidget {
  const StateDropdown({super.key});

  @override
  StateDropdownState createState() => StateDropdownState();
}

class StateDropdownState extends State<StateDropdown> {
  String? selectedState;

  final List<String> indianStates = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedState,
          hint: const Text("Select State"),
          items: indianStates
              .map((String state) => DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedState = value; // Updates the selected value
            });
          },
        ),
      ),
    );
  }
}
