import 'package:badriyya/features/public/more/view/pages/Admission/view/pages/admission.dart';
import 'package:badriyya/features/public/more/view/pages/Enquiry/view/pages/enquiry.dart';
import 'package:badriyya/features/public/more/view/pages/Gallery/pages/gallery.dart';
import 'package:badriyya/features/public/more/view/pages/coming_soon/coming_soon.dart';
import 'package:badriyya/features/public/more/view/pages/donation/donation.dart';
import 'package:badriyya/features/public/more/view/pages/dua_request/pages/dua_request_page.dart';
import 'package:badriyya/features/public/more/view/pages/institution/pages/institution.dart';
import 'package:badriyya/features/public/more/view/pages/updates/pages/updates.dart';
import 'package:badriyya/features/public/more/view/widgets/more.dart';
import 'package:flutter/material.dart';

class MoreBuilder extends StatelessWidget {
  const MoreBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> more = [
      const More(
        name: "Institution",
        image: "assets/icons/Institution.png",
        backgroundColor: Colors.blue,
        iconColor: Colors.white,
        root: Institution(),
      ),
      const More(
        name: "Admission",
        // icon: Icons.door_back_door,
        image: "assets/icons/admission.png",
        backgroundColor: Colors.orange,
        iconColor: Colors.black,
        root: AdmissionForm(),
      ),
      const More(
        name: "Enquiry",
        // icon: Icons.question_mark_rounded,
        image: "assets/icons/enquiry.png",
        backgroundColor: Colors.purple,
        iconColor: Colors.white,
        root: Enquiry(),
      ),
      const More(
        name: "Updates",
        image: "assets/icons/thuhfa.png",
        backgroundColor: Colors.blue,
        iconColor: Colors.white,
        root: Updates(),
      ),
      const More(
        name: "Dua Request",
        image: "assets/icons/ourad.png",
        backgroundColor: Colors.red,
        iconColor: Colors.white,
        root: DuaRequest(),
      ),
      const More(
        name: "Donation",
        image: "assets/icons/sample.png",
        backgroundColor: Colors.brown,
        iconColor: Colors.white,
        root: DonationScreen(),
      ),
      const More(
        name: "Gallery",
        image: "assets/icons/gallery.png",
        backgroundColor: Colors.blue,
        iconColor: Colors.white,
        root: Gallery(),
      ),
      const More(
        name: "Practical Islam",
        backgroundColor: Colors.lightGreen,
        iconColor: Colors.white,
        root: ComingSoon(tittle: "Practical Islam"),
      ),
      const More(
        name: "Ourad",
        backgroundColor: Colors.red,
        iconColor: Colors.yellow,
        root: ComingSoon(tittle: "Ourad"),
      ),
      const More(
        name: "Thuhfa",
        backgroundColor: Colors.blue,
        iconColor: Colors.white,
        root: ComingSoon(tittle: "Thuhfa"),
      ),
      const More(
        name: "Programs",
        backgroundColor: Colors.yellow,
        iconColor: Colors.white,
        root: ComingSoon(tittle: "Programs"),
      ),

      const More(
        name: "About",
        backgroundColor: Colors.grey,
        iconColor: Colors.blue,
        root: ComingSoon(tittle: "About"),
      ),
    ];
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: more.length,
      itemBuilder: (context, index) {
        return more[index];
      },
    );
  }
}
