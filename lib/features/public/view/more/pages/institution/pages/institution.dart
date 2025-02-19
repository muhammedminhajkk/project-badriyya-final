import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/view/more/pages/institution/pages/ustad_memorial_dars.dart';
import 'package:project_badriyya/features/public/view/more/pages/institution/widgets/institution_card.dart';

class Institution extends StatelessWidget {
  const Institution({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Institution",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF015D74), // Custom color
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: InstitutionCard(
                name: "Usthad Memorial Dars",
                color: Colors.blueGrey,
                root: UstadMemorialDars(),
              ),
            ),
            Expanded(
              child: InstitutionCard(
                name: "Youth School",
                color: Colors.brown,
                root: UstadMemorialDars(),
              ),
            ),
            Expanded(
              child: InstitutionCard(
                name: "Girls Model Academy",
                color: Colors.green,
                root: UstadMemorialDars(),
              ),
            ),
            Expanded(
              child: InstitutionCard(
                name: "Secondary Madrasa",
                color: Colors.orange,
                root: UstadMemorialDars(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
