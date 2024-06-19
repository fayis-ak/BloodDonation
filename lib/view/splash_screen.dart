import 'dart:async';

import 'package:blood_donation/view/superadmin/bottomnav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin/bottomnav.dart';
import 'client/bottomnav.dart';
import 'client/screens/pagehome/hompage.dart';
import 'home/home_page.dart';

class Slpash_screen extends StatefulWidget {
  const Slpash_screen({super.key});

  @override
  State<Slpash_screen> createState() => _Slpash_screenState();
}

class _Slpash_screenState extends State<Slpash_screen> {

  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () =>signIn());
  }

    Future signIn() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool AlreadyLoginUser =  pref.getBool('isLoggedIn') ?? false;
    String? email = pref.getString('email');
    String? name = pref.getString('name');

    if(AlreadyLoginUser == true && name == "AdminUser" ){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminBottomNav()

          ));
    }else if(AlreadyLoginUser == true && name == "ClientUser"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Client_BottomNav()

          ));
    }else if(AlreadyLoginUser==true && name == 'SuperAdmin'){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SuperAdminBottomNav()
            // selectPage()
          ));
    }
    else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()
            // selectPage()
          ));
    }

  }


  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
          body: Center(
              child: Image.asset('assets/6262-min-scaled.jpg',fit: BoxFit.fill,))),
    );
  }
}
