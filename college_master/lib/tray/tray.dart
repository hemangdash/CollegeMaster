import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../feature_pages/screen_sizes.dart';
import '../profile_pages/student_my_profile.dart';

class drawerStyle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 35, size.width, size.height);
    path.quadraticBezierTo(size.width - 80, size.height / 2, size.width, 0);
    path.quadraticBezierTo(size.width / 2, 40, 0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}

Widget StylishDrawer(BuildContext context) {
  SizeConfig().init(context);
  return ClipPath(
    clipper: drawerStyle(),
    child: Container(
      width: 300,
      height: SizeConfig.blockSizeVertical * 100,
      child: Stack(
        children: <Widget>[
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
              ),
            ),
          ),
          Container(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Text('Loading...');
                  DocumentSnapshot ds = snapshot.data.documents[0];
                  return ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('images/user.png')),
                            ),
                          ),
                          Text(ds['first name'] + ' ' + ds['last name'],
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Ubuntu')),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      new Divider(height: 0.5, color: Color(0xFF68c1e7)),
                      new ListTile(
                          title: new Text("My Profile",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Ubuntu')),
                          leading: new Icon(Icons.person, color: Colors.black),
                          onTap: () {
                            //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("First Page")));
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, anotherAnimation) {
                                  return User();
                                },
                                transitionDuration: Duration(milliseconds: 300),
                                transitionsBuilder: (context, animation,
                                    anotherAnimation, child) {
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
                          }),
                      new Divider(height: 0.5, color: Color(0xFF68c1e7)),
                      new ListTile(
                          title: new Text("My Colleges",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Ubuntu')),
                          leading: new Icon(Icons.school, color: Colors.black),
                          onTap: () {
                            //Navigator.of(context).pop();
                            //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                          }),
                      new Divider(height: 0.5, color: Color(0xFF68c1e7)),
                      new ListTile(
                          title: new Text("My Scholarships",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Ubuntu')),
                          leading:
                              new Icon(Icons.money_off, color: Colors.black),
                          onTap: () {
                            //Navigator.of(context).pop();
                            //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                          }),
                      new Divider(height: 0.5, color: Color(0xFF68c1e7)),
                      new ListTile(
                          title: new Text("Checklist",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Ubuntu')),
                          leading:
                              new Icon(Icons.check_circle, color: Colors.black),
                          onTap: () {}),
                      new Divider(height: 0.5, color: Color(0xFF68c1e7)),
                      new ListTile(
                          title: new Text("Visa Information",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Ubuntu')),
                          leading: new Icon(Icons.airplanemode_active,
                              color: Colors.black),
                          onTap: () {}),
                      new Divider(height: 0.5, color: Color(0xFF68c1e7)),
                      new ListTile(
                          title: new Text("Settings",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Ubuntu')),
                          leading:
                              new Icon(Icons.settings, color: Colors.black),
                          onTap: () {
                            //Navigator.of(context).pop();
                            //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                          }),
                      new Divider(height: 0.5, color: Color(0xFF68c1e7)),
                      new ListTile(
                          title: new Text("Close",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Ubuntu')),
                          leading: new Icon(Icons.cancel, color: Colors.black),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      new Divider(height: 0.5, color: Color(0xFF68c1e7)),
                    ],
                  );
                }),
          )
        ],
      ),
    ),
  );
}
