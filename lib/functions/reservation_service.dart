
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import '../models/reservation_model.dart';
import 'dates_and_time_service.dart';

class ReservationService {
  final DatabaseReference _reservationRef =
  FirebaseDatabase.instance.reference().child('reservation');

  // Replace 'userId' with the actual user ID for whom you want to fetch reservations.
  Stream<List<Reservation>> getUserReservationsStream() {
    return _reservationRef
        .child(FirebaseAuth.instance.currentUser!.uid)
        .onValue
        .map((event) {
      if (event.snapshot.value == null) {
        return <Reservation>[];
      }

      final List<Reservation> reservations = [];

      Map<dynamic, dynamic> data = (event.snapshot.value as Map<dynamic,dynamic>);


      data.forEach((key, value) {
        if (value is Map<dynamic, dynamic>) {
          final Reservation reservation = Reservation.fromSnapshotValue(value);

          reservations.add(reservation);
        } else {
          print('Invalid data format for reservation with key $key');
        }
      });

      reservations.sort((a,b){
        try {
          DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(a.selectedDate);
          String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

          DateTime parsedDate2 = DateFormat('dd-MM-yyyy').parse(b.selectedDate);
          String formattedDate2 = DateFormat('yyyy-MM-dd').format(parsedDate2);


          DateTime aDateTime = DateTime.parse("$formattedDate ${a.selectedTime}");
          DateTime bDateTime = DateTime.parse("$formattedDate2 ${b.selectedTime}");

          return aDateTime.compareTo(bDateTime);
        } catch (e) {
          print("Error parsing date: for reservation date and time");
          return 0; // Return a default value or handle the error as appropriate
        }
      });

      // Filter out dates from the past (excluding today)
      DateTime currentDate = DateTime.now();
      reservations.removeWhere((reservation) {
        String date=reservation.selectedDate;
        DateTime parsedDate = DateTime.parse("${date.split('-')[2]}-${date.split('-')[1]}-${date.split('-')[0]}");

        // Check if the parsed date is before the current date and not the same day
        if (parsedDate.isBefore(currentDate) && !isSameDay(parsedDate, currentDate)) {
          FirebaseDatabase.instance.reference().child('reservation')
              .child(reservation.barberName).child(reservation.selectedDate)
              .child('${reservation.barberName} ${reservation.selectedDate} ${reservation.selectedTime}').remove();
          FirebaseDatabase.instance.reference().child('reservation')
              .child(reservation.userId)
              .child('${reservation.barberName} ${reservation.selectedDate} ${reservation.selectedTime}').remove();
        }
        // Keep the date if it's not before the current date or is the same day
        return parsedDate.isBefore(currentDate) && !isSameDay(parsedDate, currentDate);
      });

      return reservations;
    }
    );
  }


Future<void> addReservation(String userId, Reservation reservation) async {
    await _reservationRef
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(
        '${reservation.barberName} ${reservation.selectedTime} '
            '${reservation.selectedDate}')
        .set(reservation.toMap());

    await _reservationRef
        .child(reservation.barberName)
        .child(reservation.selectedDate)
        .child(
        '${reservation.barberName} ${reservation.selectedTime} '
            '${reservation.selectedDate}')
        .set(reservation.toMap());
  }

  Future<List<Reservation>> getBarberReservations(
      String barberName, String date) async {
    DataSnapshot dataSnapshot =
    (await _reservationRef.child(barberName).child(date).once())
    as DataSnapshot;

    List<Reservation> reservations = [];

    if (dataSnapshot.value is Map) {
      (dataSnapshot.value as Map).forEach((key, value) {
        Reservation reservation = Reservation.fromSnapshot(value);
        reservations.add(reservation);
      });
    }
    return reservations;
  }

}
