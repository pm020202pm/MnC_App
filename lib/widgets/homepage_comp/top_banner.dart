import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../pages/login_page.dart';
import '../../pages/profile_page.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.topCenter,
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.greenAccent.shade400
              ),
              width: double.infinity,
            ),
          ),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              height: 296,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.purple.shade500, Colors.blue.shade400],
                    begin: Alignment.topCenter
                ),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80,),
                  Text("MEDIA AND CULTURAL COUNCIL", style: GoogleFonts.ubuntuMono(textStyle:const TextStyle(fontWeight: FontWeight.w800, fontSize: 23, color: Colors.white),)),
                  Text("IIT KANPUR", style: GoogleFonts.ubuntuMono(textStyle:const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Colors.white),))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(170, 190, 20, 10),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: Colors.white
                ),
                child: Image.asset('assets/mnc.png', height: 100,)),
          ),
          Container(
              alignment: Alignment.centerRight,
              width: double.infinity,
              child: InkWell(
                onTap: (){
                  (isLogin==false)?
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage())):
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfilePage()));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 12, 0),
                  child: Icon(Icons.login, size: 22, color: Colors.grey.shade100.withOpacity(0.6),),
                ),
              )),
        ]);
  }
}

class CustomClipPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.lineTo(0,h-150);
    path.quadraticBezierTo(w*0.6, h, w, h-80);
    path.lineTo(w,0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}