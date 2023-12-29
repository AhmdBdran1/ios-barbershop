import 'package:barber_shop/functions/add_country_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'otp_screen.dart';



class SignInScreen extends StatefulWidget {
  static const String screenRoute='/signInScreen';

  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool  showProgressIndicator= false;
   String phoneNumber='';


   void verificationFailedFunc(){

     setState(() {
       showProgressIndicator=false;
     });

     showTopSnackBar(
       Overlay.of(context),
       const CustomSnackBar.error(
         message:
         'فشل الأرسال, حاول لاحقا',
       ),
     );

     phoneNumber='0'+phoneNumber.substring(4);
     print(phoneNumber);



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
                  height: 50,
                ),


                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'أدخل رقم الهاتف الخاص بك لتلقي رمز تحقق',
                    style: TextStyle(
                      color: Colors.white,
                    // fontSize: 12.0,
                    ),
                  ),
                ),

                

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    onChanged: (value){
                      phoneNumber=value;
                    },
                    readOnly: showProgressIndicator!,


                    textDirection: TextDirection.ltr,

                    style: const TextStyle(color: Colors.white,fontSize: 23),
                    textAlign: TextAlign.left,


                    decoration: InputDecoration(


                      contentPadding: const EdgeInsets.all(7.0),

                      prefixIcon: const Icon(Icons.phone,color: Colors.orange,),
//                      labelText: 'رقم الهاتف',

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

                    if(phoneNumber!=''){

                      if(phoneNumber?.length!=10){
                        showProgressIndicator=!showProgressIndicator;

                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.error(
                            message:
                            'يجب أدخال 10 أرقام كرقم هاتف ',
                            backgroundColor: Colors.orange,

                          ),
                        );


                      }
                      else{
                        try{
                          String phonePresentNumber=phoneNumber!;
                          phoneNumber=addCountryCode.addCode(phoneNumber!);
                          signInWithPhoneNumber(context, phoneNumber!,phonePresentNumber,verificationFailedFunc);
                          showProgressIndicator=!showProgressIndicator;


                        }catch(e){
                          print(e);
                        }


                      }


                    }else{
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.error(
                          message:
                          'يجب أدخال رقم هاتف ',
                          backgroundColor: Colors.orange,

                        ),
                      );
                    }
                    }:null,
                    child:const Text('تسجيل الدخول',style: TextStyle(
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





Future<void> signInWithPhoneNumber(BuildContext context,String phoneNumber,phonePresentNumber,verificationFailedFunc) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically sign in the user if verification is done on the same device
        await _auth.signInWithCredential(credential);
        // Navigate to the next screen or perform any other action
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: ${e.message}");
        verificationFailedFunc();

      },
      codeSent: (String verificationId, int? resendToken) {

        // Save verification ID and phone number to be used in the next screen
        Map<String, String> arguments = {
          'verificationId': verificationId,
          'phoneNumber': phonePresentNumber,
        };

        Navigator.pushReplacementNamed(
          context,
          OtpScreen.screenRoute,
          arguments: arguments,
        );

      },

      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout or allow user to manually enter the code


      },
    );
  } catch (e) {

    print(e.toString());
  }
}