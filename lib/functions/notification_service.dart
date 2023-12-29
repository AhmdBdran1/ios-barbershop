
import 'package:firebase_database/firebase_database.dart';

import '../models/message_model.dart';

class NotificationsService {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<List<Message>> getAllMessages() async {
    try {
      DatabaseEvent snapshot = await _database.child('messages').once();
      Map<dynamic, dynamic> messagesMap = snapshot.snapshot.value as Map<dynamic, dynamic>;
      List<Message> messagesList = [];

      if (messagesMap != null) {
        messagesMap.forEach((key, value) {
          Map<String, dynamic> messageData = Map<String, dynamic>.from(value);
          messageData['title'] = key;
          messagesList.add(Message.fromJson(messageData));
        });


        // Sort the list of notifications by date
        messagesList.sort((a, b) {
          List<String> dateParts1 = a.date.split('-');
          String convertedDate1 = '${dateParts1[2]}-${dateParts1[1]}-${dateParts1[0]}';

          List<String> dateParts2 = b.date.split('-');
          String convertedDate2 = '${dateParts2[2]}-${dateParts2[1]}-${dateParts2[0]}';

          return DateTime.parse(convertedDate1).compareTo(DateTime.parse(convertedDate2));
        });

        return messagesList;
      } else {
        // No messages found
        return [];
      }
    } catch (error) {
      print('Error retrieving messages: $error');
      throw error;
    }
  }
}