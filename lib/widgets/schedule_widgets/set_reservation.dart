import 'package:barber_shop/functions/add_new_reservation.dart';
import 'package:barber_shop/functions/app_state_manager.dart';
import 'package:barber_shop/functions/check_network.dart';
import 'package:barber_shop/widgets/schedule_widgets/times.list.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../functions/notificaiton_service.dart';
import 'dates_list.dart';

class SetReservation extends StatefulWidget {
  final String barberName;
  const SetReservation({super.key, required this.barberName});

  @override
  State<SetReservation> createState() => _SetReservationState();
}

class _SetReservationState extends State<SetReservation> {
  final NotificationService notificationService = NotificationService();

  bool showProgressIndicator=false;
  String selectedDate='';
  String selectedTime='';
  String firstName='';
  String familyName='';


  void setSelectedDate(String value){
    setState(() {
      selectedDate=value;

    });

    print(selectedDate);
  }

  void setSelectedTime(String value){
    selectedTime=value;
    print(selectedTime);

  }

  @override
  Widget build(BuildContext context) {
    print('% $selectedDate');

    return SafeArea(
        child: Stack(
          children: [
            Stack(
                children: [Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [ Colors.black.withOpacity(0.8), Colors.black],
                    ),
                  ),
                ),
                  Positioned(
                      top: -10,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Text(widget.barberName=='njeb'?'نجيب':'امير',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white.withOpacity(0.8),
                        ),)
                  )
                ]


            ),

            Padding(
              padding: EdgeInsets.only(top: 80,),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),

                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child:SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Padding(
                            padding: const EdgeInsets.only(right: 20,top: 15),
                          child: Text('قم بأختيار التاريخ',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,

                          ),
                          ),
                        ),
                        DatesList(barberName: widget.barberName, setSelectedDate: setSelectedDate,),
                        Padding(
                          padding: const EdgeInsets.only(right: 20,top: 10),
                          child: Text('قم بأختيار الساعة',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 22,

                            ),
                          ),
                        ),
                        TimesList(barberName: widget.barberName,
                            selectedDate: selectedDate
                            , setSelectedTime: setSelectedTime),


                        Padding(
                          padding: const EdgeInsets.only(right: 20,top: 5),
                          child: Text('أسم صاحب الحجز',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 22,

                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                          child: TextField(
                            onChanged: (value){
                              firstName=value;
                            },
                            readOnly: showProgressIndicator!,
                            keyboardType: TextInputType.name,


                            style:  TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 20),



                            decoration: InputDecoration(
                              hintText: 'الأسم الأول',

                              contentPadding: const EdgeInsets.all(7.0),

                              prefixIcon:  Icon(Icons.person,color: Colors.black.withOpacity(0.8),),

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.8)), // Set the border color
                                borderRadius: BorderRadius.circular(10.0), // Set the border radius
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.8)), // Set the border color
                                borderRadius: BorderRadius.circular(10.0), // Set the border radius
                              ),

                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50,),
                          child: TextField(
                            onChanged: (value){
                              familyName=value;
                            },
                            readOnly: showProgressIndicator!,
                            keyboardType: TextInputType.name,


                            style:  TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 20),



                            decoration: InputDecoration(
                              hintText: 'أسم العائلة',

                              contentPadding: const EdgeInsets.all(7.0),

                              prefixIcon:  Icon(Icons.group,color: Colors.black.withOpacity(0.8),),

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.8)), // Set the border color
                                borderRadius: BorderRadius.circular(10.0), // Set the border radius
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.8)), // Set the border color
                                borderRadius: BorderRadius.circular(10.0), // Set the border radius
                              ),

                            ),
                          ),
                        ),


                        Visibility(
                          visible: !showProgressIndicator,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: ElevatedButton(

                                onPressed: () async {
                                  setState(() {
                                    showProgressIndicator=true;
                                  });
                                  if( !await CheckNetwork.checkInternetConnectivity()){
                                  showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                  message:
                                  'يجب ألاتصال بالأنترنيت',
                                  ),
                                  );
                                  setState(() {
                                  showProgressIndicator=false;
                                  });


                                  }else if(firstName==''){
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.error(
                                          message:
                                          'أدخل الأسم الأول',
                                          backgroundColor:Color.fromRGBO(197, 123, 58, 1),

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
                                          backgroundColor: Color.fromRGBO(197, 123, 58, 1),

                                        ),
                                      );
                                      setState(() {
                                        showProgressIndicator=false;
                                      });

                                    }else if(firstName.length>9 || familyName.length>9){

                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.error(
                                          message:
                                          'أدخل أسم أقصر',
                                          backgroundColor: Color.fromRGBO(197, 123, 58, 1),

                                        ),
                                      );
                                      setState(() {
                                        showProgressIndicator=false;
                                      });

                                    } else if(selectedTime==''||selectedDate==''){
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.error(
                                          message:
                                          'يجب أختيار التاريخ والساعة أولا',
                                          backgroundColor: Color.fromRGBO(197, 123, 58, 1),

                                        ),
                                      );
                                      setState(() {
                                        showProgressIndicator=false;
                                      });
                                    }else{

                                    try{
                                      bool isSuccess=await AddNewReservation.CreateNewReservation(firstName, familyName, widget.barberName,
                                        selectedDate, selectedTime,
                                        Provider.of<AppStateManager>(context,listen: false).flutterLocalNotificationsPlugin,
                                      );
                                      if(isSuccess){
                                        showTopSnackBar(
                                          Overlay.of(context),
                                          const CustomSnackBar.success(
                                            message:
                                            'تم الحجز',
                                            backgroundColor: Color.fromRGBO(197, 123, 58, 1),
                                          ),
                                        );
                                        Provider.of<AppStateManager>(context,listen:false).selectedIndex=0;

                                      }else{

                                        showTopSnackBar(
                                          Overlay.of(context),
                                          const CustomSnackBar.error(
                                            message:
                                            'حدث خطأ, حاول مرة اخرى',
                                          ),
                                        );
                                        setState(() {
                                          showProgressIndicator=false;
                                        });

                                      }
                                    }catch(e){
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.error(
                                          message:
                                          'حدث خطأ, حاول مرة اخرى',
                                        ),
                                      );
                                      setState(() {
                                        showProgressIndicator=false;
                                      });
                                      print(e);
                                    }

                                    }
                                },
                                style: ButtonStyle(

                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orange.shade800.withOpacity(0.5)), // Set the background color

                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 35),
                                  child: Text('حجز',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: showProgressIndicator,
                          child: const Padding(

                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: CircularProgressIndicator(color:  Color.fromRGBO(197, 123, 58, 1),),
                            ),
                          ),
                        )



                      ],
                    ),
                  ),
                ),
              ),
            )
          ],

        )
    );
  }
}

