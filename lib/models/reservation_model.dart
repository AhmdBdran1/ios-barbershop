import 'package:firebase_database/firebase_database.dart';

class Reservation {
  String barberName;
  String familyName;
  String firstName;
  String selectedDate;
  int notificationId; // Change the type to int
  String phoneNumber;
  String selectedTime;
  String userId;
  String userName;

  Reservation({
    required this.barberName,
    required this.familyName,
    required this.firstName,
    required this.selectedDate,
    required this.notificationId,
    required this.phoneNumber,
    required this.selectedTime,
    required this.userId,
    required this.userName,
  });


  factory Reservation.fromSnapshot(DataSnapshot snapshot) {
    final Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
    return Reservation(
      barberName: data?['barber_name'] ?? '',
      familyName: data?['family_name'] ?? '',
      firstName: data?['first_name'] ?? '',
      selectedDate: data?['getSelected_date'] ?? '',
      notificationId: data?['notification_id'] ?? 0,
      phoneNumber: data?['phone_number'] ?? '',
      selectedTime: data?['selected_time'] ?? '',
      userId: data?['user_id'] ?? '',
      userName: data?['user_name'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'barber_name': barberName,
      'family_name': familyName,
      'first_name': firstName,
      'getSelected_date': selectedDate,
      'notification_id': notificationId,
      'phone_number': phoneNumber,
      'selected_time': selectedTime,
      'user_id': userId,
      'user_name': userName,
    };
  }

  factory Reservation.fromSnapshotValue(Map<dynamic, dynamic> data) {
    return Reservation(
      barberName: data['barber_name'] ?? '',
      familyName: data['family_name'] ?? '',
      firstName: data['first_name'] ?? '',
      selectedDate: data['getSelected_date'] ?? '',
      notificationId: data['notification_id'] ?? 0,
      phoneNumber: data['phone_number'] ?? '',
      selectedTime: data['selected_time'] ?? '',
      userId: data?['user_id'] ?? '',
      userName: data['user_name'] ?? '',
    );


  }

}
