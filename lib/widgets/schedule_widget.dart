import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions/app_state_manager.dart';

class ScheduleWidget extends StatelessWidget {
   const ScheduleWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    top: 30,
                    left: 0,
                    right: 0,
                    bottom: 60,
                    child: Text('مين بدك يزبطك؟',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white.withOpacity(0.8),
                    ),)
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),

                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          Provider.of<AppStateManager>(context, listen: false).selectedIndex =3;
                        },
                        child: Container(
                          height: 160,
                          width: 220,
                          padding: const EdgeInsets.all(20), // Adjust padding as needed
                          decoration: BoxDecoration(

                            borderRadius: const BorderRadius.all(Radius.circular(30)),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 6.0,
                                spreadRadius: 6.0,
                                offset: const Offset(0, 5),
                              ),
                            ],

                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [ Colors.black.withOpacity(0.7), Colors.black],
                            ),

                            // border: Border.all(
                            //   width: 7.0, // Set the width of the border
                            // ),
                          ),
                          child: const Center(
                            child: Text('نجيب' ,//'أمير'
                              style:  TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: (){
                          Provider.of<AppStateManager>(context, listen: false).selectedIndex =4;

                        },
                        child: Container(
                          height: 160,
                          width: 220,
                          padding: const EdgeInsets.all(20), // Adjust padding as needed
                          decoration: BoxDecoration(

                            borderRadius: const BorderRadius.all(Radius.circular(30)),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 6.0,
                                spreadRadius: 6.0,
                                offset: const Offset(0, 5),
                              ),
                            ],

                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [ Colors.black.withOpacity(0.7), Colors.black],
                            ),

                            // border: Border.all(
                            //   width: 7.0, // Set the width of the border
                            // ),
                          ),
                          child: const Center(
                            child: Text('أمير' ,//'أمير'
                              style:  TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
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
