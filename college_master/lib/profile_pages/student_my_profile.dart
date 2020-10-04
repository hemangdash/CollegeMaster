import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../feature_pages/screen_sizes.dart';
import 'college_profile2.dart';
import 'edit_profile_pages/edit_student_profile_button.dart';

void main() {
  runApp(User());
}

String imagePath = 'images/user.png';
String name = 'Steve Smith';
String school = 'GEMS Modern Academy, Dubai';
String schooltype = "Sophomore";
double rating = 4.0;
var globalcontext;

class User extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    globalcontext = context;
    return MaterialApp(
      title: 'Register Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserProfile(title: 'CollegeMaster'),
    );
  }
}

class UserProfile extends StatefulWidget {
  UserProfile({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('CollegeMaster',
            style: TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontSize: 25,
              shadows: [
                Shadow(
                    // bottomLeft
                    offset: Offset(-0.7, -0.7),
                    color: Colors.black),
                Shadow(
                    // bottomRight
                    offset: Offset(0.7, -0.7),
                    color: Colors.black),
                Shadow(
                    // topRight
                    offset: Offset(0.7, 0.7),
                    color: Colors.black),
                Shadow(
                    // topLeft
                    offset: Offset(-0.7, 0.7),
                    color: Colors.black),
              ],
            ),
            textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: Color(0xFF68c1e7),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: SizeConfig.blockSizeHorizontal * 8,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(globalcontext),
        ),
      ),
      body: Profile(1),
    );
  }
}

class Profile extends StatefulWidget {
  int type;

  Profile(int type) {
    this.type = type;
  }

  _ProfileState createState() => _ProfileState(1);
}

class _ProfileState extends State<Profile> {
  int type;

  _ProfileState(int type) {
    this.type = type;
  }

  var _controller = ScrollController(
      initialScrollOffset: SizeConfig.blockSizeHorizontal * 23.5);

  List<String> headers = ['Price per hour', 'Interviewed'];
  List<String> values = ['20', '19'];
  List<String> qualifications = [
    'images/tedx.svg.png',
    'images/gulfnews.svg.png'
  ];

  @override
  Widget build(BuildContext context) {
    return _Profile(context, imagePath, name, school, rating, schooltype);
  }

  Widget _Profile(BuildContext context, String imagePath, String name,
      String school, double rating, String schooltype) {
    SizeConfig().init(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Loading...');
        DocumentSnapshot ds = snapshot.data.documents[0];
        if (chk) {
          name = myController.text != "" ? myController.text : ds['first name'];
          school =
              myController2.text != "" ? myController2.text : ds['last name'];
          chk = false;
        }
        return Stack(children: <Widget>[
          Container(
            height: double.infinity,
            width: SizeConfig.screenWidth,
          ),
          ClipPath(
            clipper: CustomClipPath1(),
            child: Container(
              height: 170,
              color: Color(0xFF68c1e7),
            ),
          ),
          Container(
            child: Positioned(
              width: SizeConfig.screenWidth,
              top: SizeConfig.screenHeight / 30,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: SizeConfig.screenHeight / 15,
                          height: SizeConfig.screenHeight / 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF68c1e7),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ]),
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenHeight / 5,
                        height: SizeConfig.screenHeight / 5,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ]),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: SizeConfig.screenHeight / 15,
                          height: SizeConfig.screenHeight / 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF68c1e7),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ]),
                          child: Icon(
                            Icons.message,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                  Text(
                    ds['first name'] + ' ' + ds['last name'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeVertical * 3,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical),
                  SizedBox(height: SizeConfig.blockSizeVertical),
                  SizedBox(height: SizeConfig.blockSizeVertical),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(height: SizeConfig.blockSizeVertical * 2),
                          ClipPath(
                            clipper: CustomClipPath2(),
                            child: Container(
                              height: SizeConfig.blockSizeVertical * 57,
                              color: Color(0xFF68c1e7),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  height: SizeConfig.screenHeight / 15,
                                  width: SizeConfig.blockSizeHorizontal * 30,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: new BorderSide(
                                          color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        myController.text = ds['first name'];
                                        myController2.text = ds['last name'];
                                        Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new MyApp2()));
                                      },
                                      child: Center(
                                          child: Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue,
                                            fontFamily: 'Ubuntu'),
                                        textAlign: TextAlign.center,
                                      )),
                                    ),
                                  ))),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                'My Colleges',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeVertical * 3,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20.0),
                            width: SizeConfig.blockSizeHorizontal * 90,
                            height: SizeConfig.blockSizeVertical * 39,
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('colleges')
                                    .where('isMyCollege', isEqualTo: true)
                                    .snapshots(),
                                // ignore: missing_return
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData)
                                    return Text(
                                      '',
                                      style: TextStyle(fontFamily: 'Ubuntu'),
                                    );
                                  else {
                                    return ListView.separated(
                                      controller: _controller,
                                      itemCount: snapshot.data.documents.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) {
                                        DocumentSnapshot ds =
                                            snapshot.data.documents[i];
                                        if (snapshot.data.documents.length ==
                                            0) {
                                          return Container(
                                            height: 10,
                                            child: Text(
                                              'Add some colleges to get started!',
                                              style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 20),
                                            ),
                                          );
                                        }
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                        animation,
                                                        anotherAnimation) {
                                                      return CollegeApp2(ds.id);
                                                    },
                                                    transitionDuration:
                                                        Duration(
                                                            milliseconds: 300),
                                                    transitionsBuilder:
                                                        (context,
                                                            animation,
                                                            anotherAnimation,
                                                            child) {
                                                      animation =
                                                          CurvedAnimation(
                                                              curve:
                                                                  Curves.linear,
                                                              parent:
                                                                  animation);
                                                      return SlideTransition(
                                                        position: Tween(
                                                                begin: Offset(
                                                                    1.0, 0.0),
                                                                end: Offset(
                                                                    0.0, 0.0))
                                                            .animate(animation),
                                                        child: child,
                                                      );
                                                    }));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                7, 0, 7, 12),
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    45,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black,
                                                      blurRadius: 0.5)
                                                ],
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        ds['image']),
                                                    fit: BoxFit.cover,
                                                    colorFilter: new ColorFilter
                                                            .mode(
                                                        Colors.black
                                                            .withOpacity(0.35),
                                                        BlendMode.hardLight))),
                                            child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  ds['name'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Ubuntu',
                                                      fontSize: SizeConfig
                                                              .blockSizeVertical *
                                                          2.5),
                                                )),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, i) {
                                        return SizedBox(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    3);
                                      },
                                    );
                                  }
                                }),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]);
      },
    );
  }

  Widget _buildMycollegeCard(String imagePath, String name) {
    return Container(
      width: 160,
      child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Stack(children: <Widget>[
            Container(
                height: SizeConfig.blockSizeVertical * 27,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: 15.0, bottom: 5),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeVertical * 2.5,
                      fontFamily: 'Ubuntu',
                    ),
                  )),
            ),
          ])),
    );
  }
}

class CustomClipPath1 extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomClipPath2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, 60);
    path.quadraticBezierTo(size.width / 4, 0, size.width / 2, 0);
    path.quadraticBezierTo(size.width - size.width / 4, 0, size.width, 60);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
