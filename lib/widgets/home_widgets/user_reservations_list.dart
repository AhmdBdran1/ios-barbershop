import 'package:barber_shop/widgets/home_widgets/user_reservation_card.dart';
import 'package:flutter/material.dart';

import '../../functions/reservation_service.dart';
import '../../models/reservation_model.dart';
import 'create_new_reservation.dart';

class UserReservationsList extends StatelessWidget {
  const UserReservationsList ({super.key});

  Widget build(BuildContext context) {
    final ReservationService reservationService = ReservationService();

    return  StreamBuilder<List<Reservation>>(
      // Use the stream from your ReservationService
      stream: reservationService.getUserReservationsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  const SizedBox(
            width: double.infinity,
              height: 180,
              child: Center(child: CircularProgressIndicator(color: Color.fromRGBO(197,123,58,1),))
          );
        } else if (snapshot.hasError) {
          return  const SizedBox(
            width: double.infinity,
            height: 180,
            child: CreateNewReservation(),
          ) ;
        } else {
          List<Reservation> reservations = snapshot.data ?? [];
          if (reservations.isEmpty) {
            return const SizedBox(
              width: double.infinity,
              height: 180,
              child: CreateNewReservation(),
            ) ;

          }
          // Build your UI with the list of reservations

          return Container(
            width: double.infinity,
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                return UserReservationCard(reservation: reservations[index],);
              },
            ),
          );
        }
      },
    );  }
}
