import 'package:flutter/material.dart';

import '../../functions/price_service.dart';
import '../../models/price_model.dart';

class PricesList extends StatelessWidget {
  final PriceService priceService=PriceService();
  PricesList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: priceService.getAllPrices(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(color: Color.fromRGBO(197,123,58,1),),
              ),
            );
          }else if (snapshot.hasError){
            return const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(color: Color.fromRGBO(197,123,58,1),),
              ),
            );
          }else{
            // If data is successfully fetched, check if there are messages
            List<Price> prices = snapshot.data ?? [];
            if(prices.isEmpty){
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'تم أزالة لائحة الأسعار',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 35,
                    ),
                  ),
                ),
              );
            }

            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: prices.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                prices[index].itemName,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),


                          SizedBox(width: 20,),
                          Center(
                            child: Container(
                              width: 150,
                              height: 5,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),

                          SizedBox(width: 20,),

                          Expanded(
                            child: Container(
                              child: Text(
                                prices[index].price,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );


          }


        }
    );
  }
}
