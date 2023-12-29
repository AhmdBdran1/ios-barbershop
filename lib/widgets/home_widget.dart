import 'package:barber_shop/widgets/home_widgets/user_messages_list.dart';
import 'package:barber_shop/widgets/home_widgets/user_reservations_list.dart';
import 'package:flutter/material.dart';

import '../functions/reservation_service.dart';
import '../models/reservation_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Widget build(BuildContext context) {

    return  SafeArea(
        child: Stack(
          children: [
            Stack(
              children: [Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [ Colors.black.withOpacity(0.8), Colors.black],
                  ),
                ),
              ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 60,
                  child:Image.asset('images/njeblogo.png',),
                )
              ]


            ),

            Padding(
              padding: EdgeInsets.only(top: 150,),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
                ),

                child:  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                       ListTile(
                        leading: Icon(Icons.notifications,color: Colors.black.withOpacity(0.8),),
                        title: Text(
                          'أشعارات',
                          style: TextStyle(
                          color:  Colors.black.withOpacity(0.8),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                      UserMessagesList(),
                       SizedBox(height: 10,),
                       ListTile(
                        leading: Icon(Icons.schedule_outlined,color:  Colors.black.withOpacity(0.8),),
                        title: Text(
                          'سجل الحجز',
                          style: TextStyle(
                              color:  Colors.black.withOpacity(0.8),
                              fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const UserReservationsList(),
                      SizedBox(height: 10,),


                    ],
                  ),
                ),
              ),
            )
          ],

        )
    );
  }
}

//
// UserMessagesList(),
// UserReservationsList(),