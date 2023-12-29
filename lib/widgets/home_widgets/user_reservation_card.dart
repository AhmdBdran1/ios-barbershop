import 'package:barber_shop/functions/notificaiton_service.dart';
import 'package:barber_shop/models/reservation_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../../functions/app_state_manager.dart';

class UserReservationCard extends StatelessWidget {
  final Reservation reservation;
  final GlobalKey _popupMenuKey = GlobalKey();


  UserReservationCard({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        
        width: MediaQuery.of(context).size.width*(3/4),
        height: 180,
        
        decoration: BoxDecoration(
      
          boxShadow: [
      
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2.0,
              spreadRadius: 2.0,
              offset: const Offset(0, 5),
            ),
          ],
      
      
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [ Colors.white70.withOpacity(0.3), Colors.white70.withOpacity(0.1)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Column(
              children: [
      
      
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 15,top: 20),
                  child: Row(
                    children: [
                       Text(
                        'حجز بأسم :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Text(' ${reservation.firstName} ${reservation.familyName}',
                        style:  TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                       Text(
                        'تاريخ :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Text(' ${reservation.selectedDate}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                       Text(
                        'ساعة :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Text(' ${reservation.selectedTime}',
                        style:  TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      ElevatedButton(
      
                        onPressed: (){
                          showMessageDialog(context, reservation);
                        },
                        style: ButtonStyle(
      
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(197,123,58,1)), // Set the background color
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),  // Adjust the radius as needed
                                bottomLeft: Radius.circular(30.0),  // Adjust the radius as needed
                              ),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 1,horizontal: 5),
                          child: Text('ألغاء الحجز',style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
      
      
              ],
            ),
      
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.all(20), // Adjust padding as needed
                decoration: BoxDecoration(
                  color: Colors.transparent,
      
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:  Colors.white70.withOpacity(0.5),// Set your desired border color here
                    width: 2.0, // Set the width of the border
                  ),
                ),
                child: Text(reservation.barberName == 'njeb' ? 'نجيب' : 'أمير',
                  style:  TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}




void showMessageDialog(BuildContext context,Reservation reservation) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text('تأكيد الألغاء',
          style:TextStyle(
            color: Colors.black,

          ) ,
        ),
        content:SizedBox(
          height:93,
          width: 300,

          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    const Text(
                      'حجز بأسم :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                    Text(' ${reservation.firstName} ${reservation.familyName}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    const Text(
                      'تاريخ :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                    Text(' ${reservation.selectedDate}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    const Text(
                      'ساعة :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                    Text(' ${reservation.selectedTime}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {

              FirebaseDatabase.instance
                  .ref('reservation')
                  .child(FirebaseAuth.instance.currentUser!.uid)
                  .child('${reservation.barberName} ${reservation.selectedDate} ${reservation.selectedTime}')
                  .remove()
                  .then((_) {
                print("Reservation removed successfully.");
                print(FirebaseAuth.instance.currentUser!.uid);
              })
                  .catchError((error) {
                print("Error removing reservation: $error");
              });

              FirebaseDatabase.instance
                  .ref('reservation')
                  .child(reservation.barberName).child(reservation.selectedDate)
                  .child('${reservation.barberName} ${reservation.selectedDate} ${reservation.selectedTime}')
                  .remove()
                  .then((_) {
                print("Reservation removed successfully.");
                print(FirebaseAuth.instance.currentUser!.uid);
              })
                  .catchError((error) {
                print("Error removing reservation: $error");
              });


              FirebaseDatabase.instance
                  .ref('barbers')
                  .child(reservation.barberName).child('dates')
                  .child(reservation.selectedDate).child(reservation.selectedTime).set(reservation.selectedTime)
                  .then((_) {
                print("time added successfully.");
                print(FirebaseAuth.instance.currentUser!.uid);
              })
                  .catchError((error) {
                print("Error add reservation: $error");
              });

              FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=Provider.of<AppStateManager>(context,listen: false).flutterLocalNotificationsPlugin;
              NotificationService().cancelNotification(flutterLocalNotificationsPlugin, reservation.notificationId);


              // Close the dialog
              Navigator.of(context).pop();
            },
            child: const Text('تأكيد',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,

            ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: const Text('تراجع',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
    },
  );
}