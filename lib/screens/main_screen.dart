
import 'package:barber_shop/screens/sign_in_screen.dart';
import 'package:barber_shop/widgets/drawer_widget.dart';
import 'package:barber_shop/widgets/home_widget.dart';
import 'package:barber_shop/widgets/prices_widget.dart';
import 'package:barber_shop/widgets/schedule_widget.dart';
import 'package:barber_shop/widgets/schedule_widgets/set_reservation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

import '../functions/app_state_manager.dart';

class MainScreen extends StatefulWidget {
  static const String screenRoute='/mainScreen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  final List<String> appBarTitles=['ألرئيسية','حجز','لائحة أسعار','حجز','حجز'];
  final List<Widget> widgets=[const HomeWidget(),const ScheduleWidget(),const PricesWidget(),const SetReservation(barberName: 'njeb'),const SetReservation(barberName: 'amer',)];

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,

            end: Alignment.bottomLeft,
            colors: [ Colors.black.withOpacity(0.85),Colors.black],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: true,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius:  BorderRadius.all(Radius.circular(16)),
      ),

      drawer: DrawerWidget(logOutFunction: logOut,homeWidget: homeWidget,pricesWidget: pricesWidget,scheduleWidget: scheduleWidget),
      child: Scaffold(
        appBar: AppBar(
          title:Container(
            alignment: Alignment.centerRight,
            child: Text(appBarTitles[Provider.of<AppStateManager>(context).selectedIndex],style: TextStyle(color: Colors.white),),),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          backgroundColor: Colors.black,

        ),



        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
            decoration:  BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(45)),
              gradient: LinearGradient(
                begin: Alignment.topRight,

                end: Alignment.bottomLeft,
                colors: [ Colors.black,Colors.black.withOpacity(0.70),],
              ),

            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              child: GNav(
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor:  const Color.fromRGBO(197,123,58,1),
                padding: const EdgeInsets.all(16),
                selectedIndex:Provider.of<AppStateManager>(context).selectedIndex,
                onTabChange: (value) { // handle the index change of the bottom navigation bar
                    Provider.of<AppStateManager>(context, listen: false).selectedIndex =value;
                },
                tabs: const [
                  GButton(icon: Icons.home,
                    text: 'ألرئيسية',
                  ),

                  GButton(icon: Icons.schedule,
                    text: 'حجز',

                  ),
                  GButton(icon: Icons.attach_money,
                    text:' لائحة أسعار',
                  ),

                ],

              ),
            ),
          ),
        ),
        body: widgets[Provider.of<AppStateManager>(context).selectedIndex],

    ),
    );
  }



  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }


   void logOut() {
     _advancedDrawerController.hideDrawer();
    FirebaseAuth.instance.signOut();
    Future.delayed(Duration(milliseconds: 300),(){
      Navigator.pushReplacementNamed(context,SignInScreen.screenRoute);

    });
  }


  void homeWidget(){
    _advancedDrawerController.hideDrawer();
    Future.delayed(const Duration(milliseconds: 250),(){
      setState(() {
        Provider.of<AppStateManager>(context, listen: false).selectedIndex =0;
      });
    });

  }


  void scheduleWidget(){
    _advancedDrawerController.hideDrawer();
    Future.delayed(const Duration(milliseconds: 250),(){
      setState(() {
        Provider.of<AppStateManager>(context, listen: false).selectedIndex =1;      });
    });

  }

  void pricesWidget(){
    _advancedDrawerController.hideDrawer();
    Future.delayed(const Duration(milliseconds: 250),(){
      Provider.of<AppStateManager>(context, listen: false).selectedIndex =2;
    });

  }






}
