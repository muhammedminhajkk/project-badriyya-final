import 'package:flutter/material.dart';

class InstitutionCard extends StatelessWidget {
  final String name;
  final Color color;
  final Widget root;

  const InstitutionCard(
      {super.key, required this.name, required this.color, required this.root});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => root),
          );
        },
        child: Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Container(
                    height: 70,
                    width: 90,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: const BorderRadius.only(
                        topRight:
                            Radius.circular(12), // Rounded top-right corner
                        bottomLeft:
                            Radius.circular(50), // Rounded bottom-left corner
                      ),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          "100+ Students",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, bottom: 10),
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 4,
                      )
                    ],
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
