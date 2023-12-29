import 'package:barber_shop/screens/insert_name_screen.dart';
import 'package:barber_shop/screens/main_screen.dart';
import 'package:barber_shop/screens/otp_screen.dart';
import 'package:barber_shop/screens/sign_in_screen.dart';
import 'package:barber_shop/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'functions/app_state_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase or other dependencies
  await Firebase.initializeApp();


  runApp(
    ChangeNotifierProvider(
      create: (context) => AppStateManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Almarai',
        colorSchemeSeed: const Color.fromRGBO(197,123,58,1),
      ),

      routes: {
        Splash.screenRoute:(ctx)=> const Splash(),
        SignInScreen.screenRoute:(ctx)=>const SignInScreen(),
        MainScreen.screenRoute:(ctx)=>const MainScreen(),
        insertNameScreen.screenRoute:(ctx)=>const insertNameScreen(),
        OtpScreen.screenRoute:(ctx)=>const OtpScreen(),
      },

      initialRoute:Splash.screenRoute ,


      builder: (context, child) { // set the all app to start from left to right ;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },

    );



  }
}
