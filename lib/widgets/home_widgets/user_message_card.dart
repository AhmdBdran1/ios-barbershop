import 'package:barber_shop/models/message_model.dart';
import 'package:flutter/material.dart';

class UserMessageCard extends StatelessWidget {
  final Message message;
  const UserMessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Container(
        width: MediaQuery.of(context).size.width*(3/5),
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
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start of the column
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text(
                message.title,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.bold
              
              ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,),
              child: Wrap(
                children: [
                  Text(
                    message.content,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),


      ),


        Positioned(
          bottom: 15,
          left: 20,
          child:Text(
              message.date,
            style: TextStyle(
              color: Colors.black.withOpacity(0.2),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
    ]

    );

  }
}
