import 'package:barber_shop/widgets/home_widgets/user_message_card.dart';
import 'package:flutter/material.dart';

import '../../functions/notification_service.dart';
import '../../models/message_model.dart';



class UserMessagesList extends StatelessWidget {
  final NotificationsService notificationsService = NotificationsService();

  UserMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return
       FutureBuilder<List<Message>>(
        future: notificationsService.getAllMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is being fetched, show a progress indicator
            return const SizedBox(
              height: 160,
              width: double.infinity,
              child: Center(

                child: CircularProgressIndicator(color: Color.fromRGBO(197,123,58,1),),
              ),
            );
          } else if (snapshot.hasError) {
            // If there's an error, display an error message
            return const ShowThatThereIsNoNotifications();
          } else {
            // If data is successfully fetched, check if there are messages
            List<Message> messages = snapshot.data ?? [];

            if (messages.isEmpty) {
              // If no messages, display a message
              return const ShowThatThereIsNoNotifications();
            } else {
              // If there are messages, display the list
              return Container(
                width: double.infinity,
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return UserMessageCard(message: messages[index]);
                  },
                ),
              );
            }
          }
        },
      );

  }
}


class ShowThatThereIsNoNotifications extends StatelessWidget {
  const ShowThatThereIsNoNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
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

      child: Center(
        child: Text(
          'ليس هنالك أشعارات بعد',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black.withOpacity(0.7),

          ),
        ),
      ),

    );
  }
}
