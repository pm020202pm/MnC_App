import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mnc/functions.dart';
import '../constants.dart';
import '../widgets/misc/button.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      setState(() {
        isLogin = false;
        userName= ' ';
        userUid = ' ';
      });
      toast('Logged out successfully');
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child:
        Center(
          heightFactor: 2,
          child: SingleChildScrollView(
            child: Column(
                children: [
              CircleAvatar(
                radius: 80,
                foregroundImage: NetworkImage(userImageUrl),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                userName.toUpperCase(),
                style: const TextStyle(fontSize: 23),
              ),
              const SizedBox(
                height: 40,
              ),
              Button(
                buttonText: 'Logout',
                textColor: Colors.grey[100],
                buttonBgColor: Colors.grey[400],
                onPressed: () {
                  logout().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyHomePage())));
                },
                height: 50,
                width: screenSize.width * 0.9,
                borderRadius: 15,
                fontSize: 21,
                fontWeight: FontWeight.w500,
                splashColor: Colors.red[400],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
