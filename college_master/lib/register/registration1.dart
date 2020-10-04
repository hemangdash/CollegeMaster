import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../feature_pages/multiselect_formfield.dart';
import '../feature_pages/screen_sizes.dart';
import 'registration2.dart';

void main() {
  runApp(SecondRoute());
}

var globalcontext;

class SecondRoute extends StatelessWidget {
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
  DateTime selectedDate;
  List<String> _myMajors;
  final majorsKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myMajors = [];
  }

  _saveMajors() {
    var majorForm = majorsKey.currentState;
    if (majorForm != null) {
      if (majorForm.validate()) {
        majorForm.save();
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
          child: Column(children: <Widget>[
        SizedBox(height: SizeConfig.blockSizeVertical * 20),
        Text('What do you want to study?',
            style: TextStyle(
                color: Color(0xFF68c1e7), fontSize: 25, fontFamily: 'Ubuntu')),
        SizedBox(height: SizeConfig.blockSizeVertical * 5),
        Container(
            height: SizeConfig.blockSizeVertical * 25,
            width: SizeConfig.blockSizeHorizontal * 90,
            child: MultiSelectFormField(
              autovalidate: true,
              required: true,
              chipBackGroundColor: Color(0xFF68c1e7),
              chipLabelStyle: TextStyle(fontFamily: 'Ubuntu'),
              dialogTextStyle: TextStyle(fontFamily: 'Ubuntu'),
              checkBoxActiveColor: Color(0xFF68c1e7),
              checkBoxCheckColor: Colors.white,
              type: 1,
              dialogShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              title: Text('Majors',
                  style: TextStyle(
                      fontFamily: 'Ubuntu', fontWeight: FontWeight.bold)),
              dataSource: [
                {
                  "display": "Computer Science",
                  "value": "Computer Science",
                },
                {
                  "display": "Mechanical Engineering",
                  "value": "Mechanical Engineering",
                },
                {
                  "display": "Finance",
                  "value": "Finance",
                },
                {
                  "display": "Law",
                  "value": "Law",
                },
                {
                  "display": "Medicine",
                  "value": "Medicine",
                },
                {
                  "display": "Industrial Engineering",
                  "value": "Industrial Engineering",
                },
                {
                  "display": "Electrical Engineering",
                  "value": "Electrical Engineering",
                },
              ],
              textField: 'display',
              valueField: 'value',
              okButtonLabel: 'OK',
              cancelButtonLabel: 'CANCEL',
              hintWidget: Text(
                'Please choose one or more',
                style: TextStyle(fontFamily: 'Ubuntu'),
              ),
              onSaved: (value) {
                if (value == null) return;
                setState(() {
                  _myMajors = value.cast<String>();
                  print(_myMajors);
                });
              },
            )),
      ])),
      floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: <Widget>[
              SizedBox(width: SizeConfig.blockSizeHorizontal * 8.5),
              FloatingActionButton(
                heroTag: "btnleft",
                onPressed: () => Navigator.pop(globalcontext),
                child: Icon(Icons.chevron_left),
                backgroundColor: Color(0xFF68c1e7),
              ),
              SizedBox(width: SizeConfig.blockSizeHorizontal * 64.2),
              FloatingActionButton(
                heroTag: "btnright",
                onPressed: () {
                  _saveMajors();
                  print(_myMajors);
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc('demouser')
                      .update({'majors': _myMajors});
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, anotherAnimation) {
                        return ThirdRoute();
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
                child: Icon(Icons.chevron_right),
                backgroundColor: Color(0xFF68c1e7),
              ),
            ],
          )),
    );
  }
}
