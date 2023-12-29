import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user_data.dart';

class UserGetAndSet {
  static void addUserData(UserData userData) {
    DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference().child('users');

    databaseReference
        .child(FirebaseAuth.instance.currentUser!.uid)
        .set(userData.toJson()); // Assuming you have a toJson method in your UserData class
  }
  static Future<UserData> getUserData(String userId) async {
    final reference = FirebaseDatabase.instance.reference().child('users').child(userId);

    DataSnapshot dataSnapshot = await reference.get();

    // Check if the user exists
    if (dataSnapshot.value != null) {
      // Map the snapshot to your UserData model
      return UserData.fromJson(dataSnapshot.value as Map);
    } else {
      // User not found
      return UserData(
        firstName: '-1',
        lastName: 'lastName',
        phoneNumber: 'phoneNumber',
        token: '-1',
      );
    }
  }

}
