import 'package:firebase_database/firebase_database.dart';

class Price{
  String itemName;
  String price;


  Price({
    required this.itemName,
    required this.price,
  });


  factory Price.fromJson(Map<dynamic, dynamic> json) {
    return Price(
      itemName: json['itemName'],
      price: json['price'],
    );
  }


  factory Price.fromSnapshot(DataSnapshot snapshot) {
    final Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
    return Price(
      itemName: data?['itemName'] ?? '',
      price: data?['price'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'price': price,

    };
  }


}