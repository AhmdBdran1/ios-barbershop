import 'package:flutter/material.dart';


class DrawerWidget extends StatelessWidget {
  final Function logOutFunction;
  final Function homeWidget;
  final Function scheduleWidget;
  final Function pricesWidget;
  const DrawerWidget({super.key, required this.logOutFunction, required this.homeWidget, required this.scheduleWidget, required this.pricesWidget});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
    child: Container(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
            width: 400.0,
            height: 400.0,
            margin: const EdgeInsets.only(
            top: 24.0,
            bottom: 64.0,
             ),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              ),
              child: Image.asset(
              'images/njeblogo.png',
              ),
            ),
            ListTile(
              onTap: () {
                homeWidget();
              },
              leading: Icon(Icons.home),
              title: Text('ألرئيسية'),
            ),
            ListTile(
              onTap: () {
                scheduleWidget();
              },
              leading: Icon(Icons.schedule),
              title: Text('حجز'),
            ),
            ListTile(
              onTap: () {
                pricesWidget();
              },
              leading: Icon(Icons.attach_money),
              title: Text('لائحة أسعار'),
            ),
            ListTile(
              onTap: () {
                logOutFunction();
              },
              leading: Icon(Icons.logout),
              title: Text('تسجيل الخروج'),
            ),

           ],
          ),
          ),
       ),
     );
  }
}
