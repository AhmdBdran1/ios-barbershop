import 'dart:async';
import 'package:flutter/material.dart';

import '../../functions/dates_and_time_service.dart';

class TimesList extends StatefulWidget {
  final String barberName;
  final String selectedDate;
  final Function setSelectedTime;
  const TimesList({super.key, required this.barberName, required this.selectedDate,required this.setSelectedTime});
  @override
  State<TimesList> createState() => _TimesListState();
}

class _TimesListState extends State<TimesList> with WidgetsBindingObserver {

  bool isLoading=true;
  int selectedIndex = 0;
  List<String> timesList = [];
  DateAndTimeService dateAndTimeService = DateAndTimeService();
  late StreamSubscription<List<String>> datesStreamSubscription;

  @override
  void initState() {
    super.initState();
    _subscribeToDatesStream(widget.selectedDate);
    WidgetsBinding.instance?.addObserver(this);
  }

  void _subscribeToDatesStream(String selectedDate) {
    datesStreamSubscription = dateAndTimeService
        .getTimesStream(widget.barberName, selectedDate)
        .listen((List<String> times) {
      setState(() {
        isLoading = false;
        timesList = times;
      });
      if (timesList.isEmpty) {
        isLoading = true;
        widget.setSelectedTime('');
      } else {
        widget.setSelectedTime(timesList[selectedIndex]);
      }
    });
  }

  @override
  void didUpdateWidget(TimesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      // Unsubscribe from the old stream
      datesStreamSubscription.cancel();
      // Subscribe to the new stream with the updated selectedDate
      _subscribeToDatesStream(widget.selectedDate);
      selectedIndex=0;
    }
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      datesStreamSubscription.resume();
    } else if (state == AppLifecycleState.paused) {
      datesStreamSubscription.pause();
    }
  }

  @override
  Widget build(BuildContext context) {


    // Use the updated datesList
    return Container(
      height: 170,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
          width: 2.0, // Set the width of the border (adjust as needed)
        ),

      ),
      child: isLoading?


      const Padding(
          padding: EdgeInsets.all(10),
          child: Center(child: CircularProgressIndicator(color: Color.fromRGBO(197,123,58,1),)))


          :GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Set the number of columns based on your preference
          crossAxisSpacing: 8.0, // Set the spacing between columns
          mainAxisSpacing: 8.0,
          childAspectRatio: 2.0,
          // Set the spacing between rows
        ),
        itemCount: timesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                widget.setSelectedTime(timesList[index]);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: index == selectedIndex ? const Color.fromRGBO(197, 123, 58, 1) : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  color: index == selectedIndex ? const Color.fromRGBO(197, 123, 58, 1) : Colors.black.withOpacity(0.8),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    timesList[index],
                    style: TextStyle(
                      color: index == selectedIndex ? Colors.white : Colors.black.withOpacity(0.8),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),

    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    datesStreamSubscription.cancel();
    super.dispose();
  }
}
