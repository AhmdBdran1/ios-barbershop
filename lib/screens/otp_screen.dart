import 'package:barber_shop/functions/user_get_and_set.dart';
import 'package:barber_shop/screens/insert_name_screen.dart';
import 'package:barber_shop/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../models/user_data.dart';


class OtpScreen extends StatefulWidget {
  static const String screenRoute='/otpScreen';


  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late String verificationId;
  late String phoneNumber;

  bool sendVerficationAgainForFirstTime=true;




  List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());


  @override
  void dispose() {
    for (int i = 0; i < 6; i++) {
      _controllers[i].dispose();
      _focusNodes[i].dispose();
    }
    super.dispose();
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve the arguments
    Map<String, String> arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    // Extract the values
    verificationId = arguments['verificationId'] ?? '';
    phoneNumber = arguments['phoneNumber'] ?? '';
  }


  bool showProgressIndicator=false;

  void  verificationOTPnotCorrect(){

    setState(() {
      showProgressIndicator=false;
      // Clear the input fields
      for (int i = 0; i < 6; i++) {
        _controllers[i].clear();
      }
    });
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message:
        'فشل التحقق, أملأ الرمز مرة أخرى ',

      ),
    );



  }


  void  userDataError(){

    setState(() {
      showProgressIndicator=false;
      // Clear the input fields
      for (int i = 0; i < 6; i++) {
        _controllers[i].clear();
      }
    });
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message:
        'خطأ في البيانات',

      ),
    );



  }




  @override
  Widget build(BuildContext context) {


    // Retrieve the arguments
    Map<String, String> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;



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
                  height: 50,
                ),


                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'أدخل  رمز التحقق الذي تلقيته على ألرقم',
                    style: TextStyle(
                      color: Colors.white,
                       fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),


                 Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(phoneNumber,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: List.generate(6, (index) {
                      int reverseIndex=5-index;
                      return SizedBox(
                        width: 40,
                        child: TextField(
                          autofocus: index==5?true:false,
                          style: TextStyle(color: Colors.white,fontSize: 20),
                          controller: _controllers[reverseIndex],
                          focusNode: _focusNodes[reverseIndex],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          cursorColor:Colors.transparent,

                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orange), // Set the border color
                              borderRadius: BorderRadius.circular(10.0), // Set the border radius
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white), // Set the border color
                              borderRadius: BorderRadius.circular(10.0), // Set the border radius
                            ),
                            counter: Offstage(),

                          ),
                          onChanged: (value) {
                                  if (value.isNotEmpty) {
                                  if (reverseIndex < 5) {
                                  _focusNodes[reverseIndex].unfocus();
                                  _focusNodes[reverseIndex + 1].requestFocus();
                                  }
                                  } else {
                                  // If the entered value is empty, move focus to the previous text field
                                  if (reverseIndex > 0) {
                                  _focusNodes[reverseIndex].unfocus();
                                  _focusNodes[reverseIndex - 1].requestFocus();
                                  }
                                  }
                                  if(reverseIndex==5){

                                    // Handle OTP verification logic here
                                    _focusNodes[reverseIndex].unfocus();
                                    String enteredOTP = _controllers.map((controller) => controller.text).join();
                                    // Add your OTP verification logic here
                                    setState(() {
                                      showProgressIndicator=true;
                                    });
                                    if(enteredOTP.length==6){
                                      verifyOtp(context, verificationId, enteredOTP,verificationOTPnotCorrect,userDataError,phoneNumber);
                                    }else{
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.error(
                                          message:
                                          'يجب أن يكون الرمز مؤلف من 6 أرقام',
                                          backgroundColor: Colors.orange,

                                        ),
                                      );
                                      setState(() {
                                        showProgressIndicator=false;
                                        for (int i = 0; i < 6; i++) {
                                          _controllers[i].clear();
                                        }
                                      });

                                    }

                                  }
                          },
                        ),
                      );
                    }),
                  ),
                ),



                 Visibility(

                  visible: !showProgressIndicator,
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('لم تتلقى رمز تحقق؟',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        ),

                        TextButton(
                          onPressed: (){
                            if(sendVerficationAgainForFirstTime) {
                              showTopSnackBar(
                                Overlay.of(context),
                                const CustomSnackBar.success(
                                  message:
                                  'تم أرسال رمز تحقق جديد',

                                ),
                              );
                              setState(() {
                                sendVerficationAgainForFirstTime=false;
                              });
                            }
                          },
                          child:  Text(sendVerficationAgainForFirstTime?'إعادة الأرسال':'تم ألأرسال',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),),

                        ),


                      ],
                    ),
                ),


                Visibility(
                  visible: showProgressIndicator,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: CircularProgressIndicator(

                    ),
                  ),
                )


              ],),
          ),


        ],
      ),

    );
  }
}



Future<void> verifyOtp(context,String verificationId, String otp,Function otpNotCorrect,Function userDataError,String PhoneNumber) async {
  String? userId;
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    // Sign in with the credential
    await _auth.signInWithCredential(credential);


      try {
       userId =_auth.currentUser?.uid; // Replace with the actual user ID
        print(userId);
        UserData userData = await UserGetAndSet.getUserData(userId!);
        if(userData.token=='-1' && userData.token=='-1'){
          //the user sign in for the first time , so he need to input the name to save the user data
          Navigator.pushReplacementNamed(context, insertNameScreen.screenRoute,arguments: PhoneNumber);
        }else{
          //the use logged in before
          Navigator.pushReplacementNamed(context, MainScreen.screenRoute);

        }


      } catch (e) {

        userDataError();

    }
    // OTP verification successful, navigate to the next screen or perform any other action
    print(userId);
  } catch (e) {
    otpNotCorrect();
  }
}



