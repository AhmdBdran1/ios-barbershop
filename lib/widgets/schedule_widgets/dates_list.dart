import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../functions/app_state_manager.dart';
import '../../functions/dates_and_time_service.dart';

class DatesList extends StatefulWidget {
  final String barberName;
  final Function setSelectedDate;
  const DatesList({super.key, required this.barberName, required this.setSelectedDate});
  @override
  State<DatesList> createState() => _DatesListState();
}
class _DatesListState extends State<DatesList> with WidgetsBindingObserver {
  bool isLoading=true;
  int selectedIndex = 0;
  List<String> datesList = [];
  DateAndTimeService dateAndTimeService = DateAndTimeService();
  late StreamSubscription<List<String>> datesStreamSubscription;
  @override
  void initState() {
    super.initState();
    datesStreamSubscription = dateAndTimeService.getDatesStream(widget.barberName).listen((List<String> dates) {
      setState(() {
        isLoading=false;
        datesList = dates;
      });
      if (datesList.isEmpty) {
        isLoading=true;
        widget.setSelectedDate('');
      } else {
        Provider.of<AppStateManager>(context, listen: false).selectedDate =datesList[selectedIndex];
        widget.setSelectedDate(datesList[selectedIndex]);
      }
    });

    WidgetsBinding.instance?.addObserver(this);
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
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      child: isLoading?


      const Padding(
        padding: EdgeInsets.all(10),
          child: Center(child: CircularProgressIndicator(color: Color.fromRGBO(197,123,58,1),)))


          :ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: datesList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  Provider.of<AppStateManager>(context, listen: false).selectedDate =datesList[selectedIndex];
                  widget.setSelectedDate(datesList[index]);
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
                      datesList[index],
                      style: TextStyle(
                        color: index == selectedIndex ? Colors.white : Colors.black.withOpacity(0.8),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
