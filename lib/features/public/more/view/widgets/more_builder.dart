import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/more/view/pages/Admission/pages/admission.dart';
import 'package:project_badriyya/features/public/more/view/pages/institution/pages/institution.dart';
import 'package:project_badriyya/features/public/more/view/widgets/more.dart';

class MoreBuilder extends StatelessWidget {
  const MoreBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> more = [
      const More(
          name: "Institution",
          icon: Icons.vertical_shades_closed_outlined,
          backgroundColor: Colors.blue,
          iconColor: Colors.white,
          root: Institution()),
      const More(
          name: "Admission",
          icon: Icons.door_back_door,
          backgroundColor: Colors.orange,
          iconColor: Colors.black,
          root: AdmissionForm()),
      // const More(
      //     name: "Enquiry",
      //     icon: Icons.question_mark_rounded,
      //     backgroundColor: Colors.purple,
      //     iconColor: Colors.white),
      // const More(
      //     name: "Practical Islam",
      //     icon: Icons.handshake,
      //     backgroundColor: Colors.lightGreen,
      //     iconColor: Colors.white),
      // const More(
      //     name: "Ourad",
      //     icon: Icons.hexagon_outlined,
      //     backgroundColor: Colors.red,
      //     iconColor: Colors.yellow),
      // const More(
      //     name: "Thuhfa",
      //     icon: Icons.calendar_month,
      //     backgroundColor: Colors.blue,
      //     iconColor: Colors.white),
      // const More(
      //     name: "Dua Request",
      //     icon: Icons.handshake,
      //     backgroundColor: Color.fromARGB(255, 19, 69, 21),
      //     iconColor: Colors.white),
      // const More(
      //     name: "Donation",
      //     icon: Icons.handshake,
      //     backgroundColor: Colors.brown,
      //     iconColor: Colors.white),
      // const More(
      //     name: "Programs",
      //     icon: Icons.handshake,
      //     backgroundColor: Colors.yellow,
      //     iconColor: Colors.white),
      // const More(
      //     name: "Updates",
      //     icon: Icons.handshake,
      //     backgroundColor: Colors.blue,
      //     iconColor: Colors.white),
      // const More(
      //     name: "Gallery",
      //     icon: Icons.handshake,
      //     backgroundColor: Colors.pink,
      //     iconColor: Colors.white),
      // const More(
      //     name: "About",
      //     icon: Icons.handshake,
      //     backgroundColor: Colors.grey,
      //     iconColor: Colors.blue),
    ];
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemCount: more.length,
        itemBuilder: (context, index) {
          return more[index];
        });
  }
}
