import 'package:barber_shop/functions/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateNewReservation extends StatelessWidget {
  const CreateNewReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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

      child:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('لم تقم بأي حجز بعد',
              style:TextStyle(
                  color: Colors.black.withOpacity(0.7),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ) ,
            ),


            SizedBox(height: 20,),


            ElevatedButton(

                onPressed: (){
                  Provider.of<AppStateManager>(context,listen:false).selectedIndex=1;
                },
              style: ButtonStyle(

                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange.shade800.withOpacity(0.5)), // Set the background color

              ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                  child: Text('للحجز',style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
            )

          ],
        ),
      ),

    );
  }
}
