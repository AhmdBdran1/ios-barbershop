import 'package:barber_shop/functions/user_get_and_set.dart';
import 'package:barber_shop/models/user_data.dart';
import 'package:barber_shop/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class insertNameScreen extends StatefulWidget {
  static const String screenRoute='/insertNameScreen';
  const insertNameScreen({super.key});


  @override
  State<insertNameScreen> createState() => _insertNameScreenState();
}



class _insertNameScreenState extends State<insertNameScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

// Correct usage with 'await' to get the FCM token
  bool showProgressIndicator=false;
  String phoneNumber='';
  String userToken='';
  String firstName='';
  String familyName='';



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Move your code here
    phoneNumber = ModalRoute.of(context)!.settings.arguments as String;
    _firebaseMessaging.getToken().then((token) {
      userToken=token!;
      // Save the token to your database or use it as needed.
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/background4.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),




          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset('images/njeblogo.png',)
                ),

                SizedBox(
                  height: 10,
                ),


                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'أدخل الأسم الأول',
                    style: TextStyle(
                      color: Colors.white,
                       fontSize: 20.0,
                    ),
                  ),
                ),



                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    onChanged: (value){
                      firstName=value;
                    },
                    readOnly: showProgressIndicator!,
                    keyboardType: TextInputType.name,


                    style: const TextStyle(color: Colors.white,fontSize: 23),


                    decoration: InputDecoration(

                      contentPadding: const EdgeInsets.all(7.0),

                      prefixIcon: const Icon(Icons.person,color: Colors.orange,),
//                      labelText: 'الأسم الأول',

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange), // Set the border color
                        borderRadius: BorderRadius.circular(10.0), // Set the border radius
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange), // Set the border color
                        borderRadius: BorderRadius.circular(10.0), // Set the border radius
                      ),

                    ),
                  ),
                ),


                const SizedBox(
                  height: 25,
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'أدخل أسم العائلة',
                    style: TextStyle(
                      color: Colors.white,
                       fontSize: 20,
                    ),
                  ),
                ),



                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    onChanged: (value){
                      familyName=value;
                    },
                    readOnly: showProgressIndicator!,
                    keyboardType: TextInputType.name,


                    style: const TextStyle(color: Colors.white,fontSize: 23),


                    decoration: InputDecoration(

                      contentPadding: const EdgeInsets.all(7.0),

                      prefixIcon: const Icon(Icons.group,color: Colors.orange,),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange), // Set the border color
                        borderRadius: BorderRadius.circular(10.0), // Set the border radius
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange), // Set the border color
                        borderRadius: BorderRadius.circular(10.0), // Set the border radius
                      ),

                    ),
                  ),
                ),





                const SizedBox(
                  height: 30,
                ),


                ElevatedButton(

                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        // Use transparent color for all states
                        return Colors.transparent;
                      },
                    ),

                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                        side: BorderSide(color: Colors.orange),
                      ),
                    ),

                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    ),


                  ),
                  onPressed:!showProgressIndicator? (){
                    setState(() {
                      showProgressIndicator=!showProgressIndicator;
                    });




                    if(firstName==''){
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.error(
                          message:
                          'أدخل الأسم الأول',
                          backgroundColor: Colors.orange,

                        ),
                      );
                      setState(() {
                        showProgressIndicator=false;
                      });




                    }else if (familyName==''){
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.error(
                          message:
                          'أدخل أسم العائلة',
                          backgroundColor: Colors.orange,

                        ),
                      );
                      setState(() {
                        showProgressIndicator=false;
                      });

                    }else{

                      UserData userData=UserData(firstName: firstName, lastName: familyName, phoneNumber: phoneNumber, token: userToken);
                      UserGetAndSet.addUserData(userData);
                      Navigator.pushReplacementNamed(context, MainScreen.screenRoute);


                    }


                  }:null,
                  child:const Text('أبدأ',style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                    textAlign: TextAlign.center,


                  ),
                ),



              ],),
          ),

          Visibility(
            visible: showProgressIndicator,
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: CircularProgressIndicator(

                ),
              ),
            ),
          )


        ],
      ),
    );
  }
}
