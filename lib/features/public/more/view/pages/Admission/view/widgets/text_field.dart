import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 12.0, bottom: 4),
    child: Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    ),
  );
}

Widget buildTextField(
  TextEditingController ctrlr,
  TextInputType type, {
  String? hint,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextField(
      controller: ctrlr,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hint?.isNotEmpty == true ? hint : null,
        hintStyle: const TextStyle(fontSize: 20, color: Colors.grey),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
    "West Bengal",
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
          items:
              indianStates
                  .map(
                    (String state) => DropdownMenuItem<String>(
                      value: state,
                      child: Text(state),
                    ),
                  )
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

Widget buildDatePickerField(BuildContext context, TextEditingController ctrlr) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextField(
      controller: ctrlr,
      readOnly: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        hintText: "dd/mm/yyyy",
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          ctrlr.text = DateFormat(
            "dd/MM/yyyy",
          ).format(pickedDate); // Formats as DD/MM/YYYY
        }
      },
    ),
  );
}
