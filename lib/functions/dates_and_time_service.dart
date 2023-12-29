
import 'package:barber_shop/functions/app_state_manager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateAndTimeService{
   Stream<List<String>> getDatesStream(String barberName) {
    final DatabaseReference datesReference =
    FirebaseDatabase.instance.reference().child('barbers');
    return datesReference
        .child(barberName).child('dates').orderByKey()
        .onValue
        .map((event) {
      if (event.snapshot.value == null) {
        return <String>[];
      }
      final List<String> dates = [];
      Map<dynamic, dynamic> data = (event.snapshot.value as Map<dynamic,
          dynamic>);
      data.forEach((key, value) {
        dates.add(key);
      });


        dates.sort((a, b) {
          DateTime aDate = DateTime.parse("${a.split('-')[2]}-${a.split('-')[1]}-${a.split('-')[0]}");
          DateTime bDate = DateTime.parse("${b.split('-')[2]}-${b.split('-')[1]}-${b.split('-')[0]}");
          return aDate.compareTo(bDate);
        });



      // Filter out dates from the past (excluding today)
      DateTime currentDate = DateTime.now();
      dates.removeWhere((date) {
        DateTime parsedDate = DateTime.parse("${date.split('-')[2]}-${date.split('-')[1]}-${date.split('-')[0]}");

        // Check if the parsed date is before the current date and not the same day
        if (parsedDate.isBefore(currentDate) && !isSameDay(parsedDate, currentDate)) {
          FirebaseDatabase.instance.reference().child('barbers').child(barberName).child('dates').child(date).remove();
        }

        // Keep the date if it's not before the current date or is the same day
        return parsedDate.isBefore(currentDate) && !isSameDay(parsedDate, currentDate);
      });

      return dates;
    }
    );
  }





   Stream<List<String>> getTimesStream(String barberName,String date) {
     final DatabaseReference datesReference =
     FirebaseDatabase.instance.reference().child('barbers');
     return datesReference
         .child(barberName).child('dates').child(date)
         .onValue
         .map((event) {
       if (event.snapshot.value == null) {
         return <String>[];
       }

       final List<String> times = [];

       Map<dynamic, dynamic> data = (event.snapshot.value as Map<dynamic,
           dynamic>);


       if(date!='') {
         data.forEach((key, value) {
           times.add(key);
         });


         times.sort((a, b) {
           try {
             DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(date);
             String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

             DateTime aDateTime = DateTime.parse("$formattedDate $a");
             DateTime bDateTime = DateTime.parse("$formattedDate $b");

             return aDateTime.compareTo(bDateTime);
           } catch (e) {
             print("Error parsing date: $date, time: $a or $b. Error: $e");
             return 0; // Return a default value or handle the error as appropriate
           }
         });


         // Filter out times from the past (excluding today if the hour has passed)
         DateTime currentTime = DateTime.now();
         times.removeWhere((time) {
           DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(date);
           String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
           DateTime parsedTime = DateTime.parse("$formattedDate $time");
           // Check if the parsed time is before the current time
           if (parsedTime.isBefore(currentTime)) {
             FirebaseDatabase.instance.reference().child('barbers').child(
                 barberName).child('dates').child(date).child(time).remove();
             return true;
           }
           // For future dates, keep all times
           return false;
         });
       }
       return times;
     }
     );
   }
}



// Function to check if two DateTime objects represent the same day
bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
}