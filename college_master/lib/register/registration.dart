import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../feature_pages/screen_sizes.dart';
import 'registration1.dart';

void main() {
  runApp(FirstRoute());
}

var globalcontext;

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globalcontext = context;
    return MaterialApp(
      title: 'Register Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Register Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
          child: Column(children: <Widget>[
        SizedBox(height: SizeConfig.blockSizeVertical * 20),
        Text('Let\'s get to know you',
            style: TextStyle(
                color: Color(0xFF68c1e7), fontSize: 25, fontFamily: 'Ubuntu')),
        SizedBox(height: SizeConfig.blockSizeVertical * 5),
        Container(
          width: SizeConfig.blockSizeHorizontal * 70,
          child: TextField(
              controller: firstNameController,
              obscureText: false,
              style: TextStyle(fontFamily: 'Ubuntu'),
              cursorColor: Color(0xFF68c1e7),
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: 'First Name')),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 5),
        Container(
          width: SizeConfig.blockSizeHorizontal * 70,
          child: TextField(
              controller: lastNameController,
              obscureText: false,
              style: TextStyle(fontFamily: 'Ubuntu'),
              cursorColor: Color(0xFF68c1e7),
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: 'Last Name')),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 10),
      ])),
      floatingActionButton: FloatingActionButton(
        heroTag: "btnright",
        onPressed: () {
          print(firstNameController.text + " " + lastNameController.text);
          FirebaseFirestore.instance
              .collection('users')
              .doc('demouser')
              .update({'first name': firstNameController.text});
          FirebaseFirestore.instance
              .collection('users')
              .doc('demouser')
              .update({'last name': lastNameController.text});
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, anotherAnimation) {
                return SecondRoute();
              },
              transitionDuration: Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, anotherAnimation, child) {
                animation =
                    CurvedAnimation(curve: Curves.linear, parent: animation);
                return SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(animation),
                  child: child,
                );
              }));
        },
        child: Icon(Icons.chevron_right),
        backgroundColor: Color(0xFF68c1e7),
      ),
    );
  }
}
