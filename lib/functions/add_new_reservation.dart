

import 'package:barber_shop/models/reservation_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'app_state_manager.dart';
import 'notificaiton_service.dart';

class AddNewReservation{

  static Future<bool> CreateNewReservation( String firstName,String familyName,String barberName,String date ,String time,FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    DatabaseReference userReservationDestination=FirebaseDatabase.instance.reference()
        .child('reservation').child(FirebaseAuth.instance.currentUser!.uid);

    DatabaseReference barberReservationDestination=FirebaseDatabase.instance.reference().child('reservation').child(barberName).child(date);

    try {
      DatabaseReference ref = FirebaseDatabase.instance.reference()
          .child('barbers')
          .child(barberName)
          .child('dates')
          .child(date)
          .child(time);

      DatabaseEvent event = await ref.once();
      DataSnapshot snapshot = event.snapshot;

      if(snapshot.exists){
        ref.remove();

        DatabaseReference userRef=FirebaseDatabase.instance.reference().child('users').child(FirebaseAuth.instance.currentUser!.uid);
        // Get first name and last name
        DatabaseEvent event1 = await userRef.child('firstName').once();
        DataSnapshot nameSnapsshot = event1.snapshot;
        String firstNameTemp = nameSnapsshot.value as String;

        DatabaseEvent event2 = await userRef.child('lastName').once();
        DataSnapshot lastNameSnapshot = event2.snapshot;
        String lastName = lastNameSnapshot.value as String;

        String userName = '$firstNameTemp $lastName';

        // Get phone number
        DatabaseEvent event3 = await userRef.child('phoneNumber').once();
        DataSnapshot phoneNumberSnapshot = event3.snapshot;
        
        String phoneNumber = phoneNumberSnapshot.value as String;

        int notificationId=generateUniqueIdForNotification();


        Reservation reservation=Reservation(barberName: barberName,
            familyName: familyName, firstName: firstName, selectedDate: date,
            notificationId: notificationId, phoneNumber: phoneNumber, selectedTime: time,
            userId: FirebaseAuth.instance.currentUser!.uid, userName: userName);


        userReservationDestination.child('$barberName $date $time').set(reservation.toMap());
     

        barberReservationDestination.child('$barberName $date $time').set(reservation.toMap());

        try{
          // Convert date string to DateTime
          DateTime date = DateFormat('dd-MM-yyyy').parse(reservation.selectedDate);

          // Convert time string to DateTime
          DateTime time = DateFormat('HH:mm').parse(reservation.selectedTime);

          // Combine date and time
          DateTime scheduledDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);

          final NotificationService notificationService = NotificationService();

          notificationService.scheduleNotification(
            flutterLocalNotificationsPlugin,
            reservation.notificationId,
            'حان موعد الحلاقة',
            'ألرجاء التوجه الى المحلقة, ونعيما سلفا',
            scheduledDateTime,
          );

        }catch(e){
         print(e);
        }
        return true;
      }
      return false;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to check destination existence: $e');
    }



  }


}
int generateUniqueIdForNotification() {
  // Using current timestamp as a unique identifier for notifications
  DateTime now = DateTime.now();
  return now.microsecondsSinceEpoch % (1 << 31);
}
