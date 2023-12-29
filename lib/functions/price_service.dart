
import 'package:firebase_database/firebase_database.dart';

import '../models/price_model.dart';
class PriceService {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<List<Price>> getAllPrices() async {
    try {
      DatabaseEvent snapshot = await _database.child('prices').once();
      Map<dynamic, dynamic> pricesMap = snapshot.snapshot.value as Map<dynamic, dynamic>;

      List<Price> pricesList = [];

      if (pricesMap != null) {
        pricesMap.forEach((key, value) {
          Map<dynamic, dynamic> priceData = Map<dynamic, dynamic>.from(value);
          pricesList.add(Price.fromJson(priceData));
        });

        return pricesList;
      } else {
        // Handle the case where no prices are found
        return [];
      }
    } catch (error) {
      print('Error retrieving prices: $error');
      throw error;
    }
  }
}
