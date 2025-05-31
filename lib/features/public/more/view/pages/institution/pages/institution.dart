import 'package:badriyya/features/public/more/view/pages/institution/widgets/institution_card.dart';
import 'package:flutter/material.dart';

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
      body: Stack(
        children: [
          Positioned(
            // top: 50,
            left: -80,
            child: Container(
              width: 380,
              height: 380,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color.fromARGB(255, 121, 232, 254), Colors.white],
                  radius: 0.5,
                ),
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 100,
            child: Container(
              width: 380,
              height: 380,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color.fromARGB(255, 121, 232, 254), Colors.white],
                  radius: 0.5,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: InstitutionCard(
                    name: "C Usthad Memorial Dars",

                    image: "assets/Institution1.jpg",
                    description:
                        "A cherished institution under Badriyya, serves as a nurturing ground for students, offering a rich blend of religious, spiritual, cultural, and academic education.\n\nIt fosters an environment where knowledge and values intertwine, shaping individuals with wisdom and integrity. Under the dedicated leadership of Principal Fasal Saqafi Narikkuni, the institution continues to guide students on a path of enlightenment and personal growth, staying true to its mission of education and character development.",
                  ),
                ),
                Expanded(
                  child: InstitutionCard(
                    name: "Youth School",
                    image: "assets/institution2.jpg",
                    description:
                        "Youth school empowers young minds, shaping them into confident, disciplined leaders guided by Islamic values. It cultivates an atmosphere where students embrace responsibility, kindness, and inner strength.\n\nThrough enriching education and character-building, the school instils wisdom and integrity, preparing its students to face life’s journey with resilience and purpose.",
                  ),
                ),
                Expanded(
                  child: InstitutionCard(
                    name: "Girls Model Academy",

                    image: "assets/Institution3.jpg",
                    description:
                        "Girls Model Academy is an inspiring online platform where young women are empowered with knowledge, confidence, and purpose, all deeply rooted in Islamic values.\n\nIn a supportive virtual space, students cultivate faith, integrity, and wisdom, shaping their character and future with strength and grace. Through enriching education and personal growth, the academy equips them to lead with dignity, ambition, and a commitment to their beliefs, preparing them to shine in every aspect of life.",
                  ),
                ),
                Expanded(
                  child: InstitutionCard(
                    name: "Secondary Madrasa",

                    image: "assets/Institution4.jpg",
                    description:
                        "Higher secondary madrasa combines academic learning with Islamic teachings, shaping students with knowledge, faith, and discipline. It nurtures wisdom and integrity, preparing them to confidently face life’s challenges while staying true to their values. The institution fosters leadership and critical thinking, encouraging students to excel in both their studies and personal growth. Through a strong moral foundation, it instils respect, responsibility, and a commitment to serving the community. By integrating modern education with timeless wisdom, it equips students to navigate the world with purpose and conviction.",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
