import 'package:barber_shop/widgets/price_widgets/prices_list.dart';
import 'package:flutter/material.dart';


class PricesWidget extends StatelessWidget {

  const PricesWidget({super.key});

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
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                  child: PricesList(),
                ),
              ),
            )
          ],

        )
    );
  }
}
