import 'package:barber_shop/functions/user_get_and_set.dart';
import 'package:barber_shop/screens/main_screen.dart';
import 'package:barber_shop/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_data.dart';




class Splash extends StatefulWidget {
  static const screenRoute='/splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  void initState() {
    super.initState();

    // Wait for 3 seconds using Future.delayed
    Future.delayed(const Duration(seconds: 2), () async {
      // Check if a user is already logged in
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        UserData userData=await UserGetAndSet.getUserData(user.uid);
        if(userData.firstName=='-1'&&userData.token=='-1'){
          //user logged in but he didn't complete the insertion of the data
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, SignInScreen.screenRoute);
        }else{
          // User is logged in, navigate to home screen
          Navigator.pushReplacementNamed(context,MainScreen.screenRoute );
        }

      } else {
        // User is not logged in, navigate to login screen
        Navigator.pushReplacementNamed(context, SignInScreen.screenRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('images/background4.png',
               fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Image.asset('images/njeblogo.png'),
            ),
          ),

          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
          )

        ],
      ),
    );
  }
}
