import 'package:college_master/feature_pages/screen_sizes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uni-T',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: FirstScreenContainer(),
    );
  }
}

class FirstScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF68c1e7),
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(height: 3),
          ),
          Expanded(
              flex: 7,
              child: Center(
                child: Column(
                  children: [
                    Image(
                      height: SizeConfig.blockSizeVertical * 30,
                      image: AssetImage('images/gradhat.png'),
                    ),
                    Text(
                      'CollegeMaster',
                      style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.blockSizeHorizontal * 9,
                          shadows: [
                            Shadow(
                                blurRadius: 5,
                                color: Colors.black.withOpacity(0.5))
                          ]),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, anotherAnimation) {
                        return FirstRoute();
                      },
                      transitionDuration: Duration(milliseconds: 300),
                      transitionsBuilder:
                          (context, animation, anotherAnimation, child) {
                        animation = CurvedAnimation(
                            curve: Curves.linear, parent: animation);
                        return SlideTransition(
                          position: Tween(
                                  begin: Offset(1.0, 0.0),
                                  end: Offset(0.0, 0.0))
                              .animate(animation),
                          child: child,
                        );
                      }));
                },
                color: Colors.white,
                disabledElevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.black)),
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeHorizontal * 5),
                ),
              )),
          Expanded(
            flex: 3,
            child: SizedBox(height: 1),
          )
        ],
      ),
    );
  }
}
