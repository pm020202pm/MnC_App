import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../constants.dart';
import '../functions.dart';
import '../widgets/misc/button.dart';
import '../widgets/misc/custom_textfield.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        setState(() {
          int length = user.email!.length-11;
          userName = user.email!.substring(0, length);
          userUid=user.uid;
          isLogin=true;
        });
        toast('Logged in successful as $userName');
      }
      emailController.clear();
      passwordController.clear();
    }
    catch (e) {
    }
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              children: [
                Text('only admin & club coordinators are allowed to login', style: TextStyle(fontSize: 12, color: Colors.red.shade300),),
                const Gap(30),
                MyTextField(controller: emailController, labelText: 'Email', boxHeight: 70,),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 70,
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 14,),
                        hintStyle: TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue, width: 0,),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue, width: 1,),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Button(
                  buttonText: 'Login',
                  textColor: Colors.lightBlue,
                  buttonBgColor: Colors.lightGreenAccent,
                  onPressed:(){
                    signInWithEmailAndPassword(emailController.text, passwordController.text).then((value) => (isLogin)?  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyHomePage())): toast('Enter correct email Id or password'));
                  },
                  height: 45, width: screenSize.width*0.9, borderRadius: 15,
                  splashColor: Colors.green[500],
                ),
                const Gap(40),
                Button(
                  buttonText: 'return to Home Page',
                  textColor: Colors.lightBlue,
                  buttonBgColor: Colors.blue.shade50,
                  onPressed:(){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyHomePage()));},
                  height: 45, width: screenSize.width*0.9, borderRadius: 15,
                  splashColor: Colors.green[500],
                ),
              ],
            ),
        ),
      )
    );

  }
}
