import 'package:blood_donation/view/login_signUp/admin_suadmin_login.dart';
import 'package:blood_donation/view/login_signUp/client_login.dart';
import 'package:blood_donation/view/login_signUp/super_adminlog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(

            // backgroundColor: Colors.white,
            body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                // color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .050,
                    vertical: MediaQuery.of(context).size.width * .010,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
                      Text(
                        'Welcome to Blood Donation',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: MediaQuery.of(context).size.height * .025,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Choose Your',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * .035,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Login !',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: MediaQuery.of(context).size.height * .025,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // SizedBox(
            //   height: MediaQuery.of(context).size.height * .05,
            // ),

            // loggin
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * .8,
                    decoration: const BoxDecoration(),
                    child: Lottie.asset(
                      
                      repeat: true,
                      'assets/images/animation/Animation - 1709290188285 (1).json',
                    ),
                    //child: Image.asset("assets/Gridview/animatedblood.gif")
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.150,
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .090,
                                width: MediaQuery.of(context).size.width * .20,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/blood-bag.png'),
                                  ),
                                  color: Colors.red.shade200,
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * .040,
                                  ),
                                ),
                              ),
                            ),
                            Text('Client',
                                style: TextStyle(fontWeight: FontWeight.w500))
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Admiss_login()));
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .090,
                                width: MediaQuery.of(context).size.width * .20,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/blood-sample.png')),
                                  color: Colors.red.shade200,
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * .040,
                                  ),
                                ),
                              ),
                            ),
                            Text('Admin',
                                style: TextStyle(fontWeight: FontWeight.w500))
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Super_login(),
                                  ),
                                );
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .090,
                                width: MediaQuery.of(context).size.width * .20,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/blood-analysis.png',
                                    ),
                                  ),
                                  color: Colors.red.shade200,
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * .040,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Super admin',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
                child: Transform.rotate(
              angle: 180 * 3.1415926535 / 180,
              child: Stack(
                children: <Widget>[
                  Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        color: Colors.red.shade200,
                        // height: 120,
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Colors.red,
                      // height: 110,
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ),
                ],
              ),
            ))
          ],
        )),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);

    var firstStart = Offset(size.width / 5, size.height);

    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);

    var secondEnd = Offset(size.width, size.height - 10);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
