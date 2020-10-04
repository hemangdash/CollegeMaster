import 'dart:math' show Random, atan2, cos, pi, sin, sqrt;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../appointment_pages/appointment_confirmation.dart';
import '../feature_pages/calendar_timeline.dart';
import '../feature_pages/screen_sizes.dart';
import '../feature_pages/slimy_card.dart';
import 'StudentInterviewer.dart';

bool built = false;

class StudentInterviewing extends StatefulWidget {
  final List<StudentInterviewer> list = new List<StudentInterviewer>();
  final String description =
      "I have experience with UCAS, Common App and Canada admissions. Looking forward to helping all of you guys";

  void setImagePath(List<StudentInterviewer> list) {
    for (int i = 0; i < list.length; i++) {
      list[i].imagePath = "images/image" + (i + 1).toString() + ".png";
    }
  }

  void setUnis(List<StudentInterviewer> list) {
    List<String> listUnis = new List<String>();
    listUnis.add("Georgia Institute of Technology");
    listUnis.add("University of Cambridge");
    listUnis.add("University of Oxford");
    listUnis.add("Harvard University");
    listUnis.add("Carnegie Mellon University");
    listUnis.add("Stanford University");
    listUnis.add("Columbia University");
    listUnis.add("MIT");
    Random random = new Random();
    for (int i = 0; i < list.length; i++) {
      list[i].university = listUnis[random.nextInt(listUnis.length)];
    }
  }

  void setPrices(List<StudentInterviewer> list) {
    Random random = new Random();
    for (int i = 0; i < list.length; i++) {
      list[i].pricing = (random.nextInt(100) + 10) * 1.0;
    }
  }

  void setDistances(List<StudentInterviewer> list) {
    for (int i = 0; i < list.length; i++) {
      list[i].distance = distanceCalculation(
          list[i].latitude, list[i].longitude, 37.785834, -122.406417);
    }
  }

  double distanceCalculation(
      double lat1, double lon1, double lat2, double lon2) {
    final int radius = 6371;
    double latDistance = degreesToRadians(lat2 - lat1);
    double lonDistance = degreesToRadians(lon2 - lon1);
    double vbl = sin(latDistance / 2) * sin(latDistance / 2);
    vbl += (cos(degreesToRadians(lat1)) *
        cos(degreesToRadians(lat2)) *
        sin(lonDistance / 2) *
        sin(lonDistance / 2));
    double vbl2 = 2 * atan2(sqrt(vbl), sqrt(1 - vbl));
    double distance = radius * vbl2;
    return distance / 1.6;
  }

  double degreesToRadians(double degree) {
    return (degree * pi / 180.0);
  }

  double radiansToDegrees(double radians) {
    return (radians * 180 / pi);
  }

  List<StudentInterviewer> getListForMap() {
    List<StudentInterviewer> myList = new List<StudentInterviewer>();
    myList.add(new StudentInterviewer(
        "Catherine Smith", description, 33.74, -84.388, "Atlanta, GA"));
    myList.add(new StudentInterviewer(
        "Dana Hudson", description, 42.331, -83.0458, "Detroit, MI"));
    myList.add(new StudentInterviewer("Carla Jane", description, 34.0708781,
        -118.44684973, "Los Angeles, CA"));
    myList.add(new StudentInterviewer(
        "Emma Carlson", description, 40.7128, -74.0060, "New York"));
    myList.add(new StudentInterviewer(
        "Amy Carlos", description, 37.3541, -121.9552, "Santa Clara, CA"));
    myList.add(new StudentInterviewer(
        "Sasha Wayne", description, 47.7511, -120.7401, "Seattle, WA"));
    myList.add(new StudentInterviewer(
        "Andrea Hooper", description, 40.6331, -89.3985, "Galena, IL"));
    myList.add(new StudentInterviewer(
        "Jerry Smith", description, 33.0918, -96.6989, "Plano, TX"));
    myList.add(new StudentInterviewer(
        "Shawn Gomes", description, 27.6648, -81.5158, "Miami, FL"));
    myList.add(new StudentInterviewer(
        "Dave Watson", description, 49.54, -97.7, "Winnipeg, Canada"));
    myList.add(new StudentInterviewer(
        "Richard Jones", description, 49.13, -123.06, "Vancouver, Canada"));
    myList.add(new StudentInterviewer(
        "Tom Smith", description, 37.87122017, -122.25928187, "Berkeley, CA"));
    myList.add(new StudentInterviewer(
        "Jennifer Wang", description, 40.27, -79.57, "Pittsburgh, PA"));
    myList.add(new StudentInterviewer(
        "James Anthony", description, 45.24, -75.43, "Ottawa, Canada"));
    myList.add(new StudentInterviewer(
        "Derrick Shaw", description, 39.57, -75.10, "Philadelphia, PA"));
    myList.add(new StudentInterviewer(
        "Brad Simpson", description, 29.57, -90.4, "New Orleans, Louisiana"));
    myList.add(new StudentInterviewer(
        "Shawn Ng", description, 43.2, -81.34, "Ontario, Canada"));
    myList.add(new StudentInterviewer(
        "Cody Knope", description, 33.46, -118.11, "Long Beach, CA"));
    myList.add(new StudentInterviewer(
        "James Hart", description, 34.3, -118.15, "Los Angeles, CA"));
    myList.add(new StudentInterviewer(
        "Kris Luo", description, 45.30, -73.35, "Montreal, Canada"));
    myList.add(new StudentInterviewer(
        "Winston Reid", description, 51.38, -2.36, "Bath, U.K."));
    myList.add(new StudentInterviewer(
        "Jared Buttler", description, 51.5098, -0.1180, "London, U.K."));
    myList.add(new StudentInterviewer(
        "Carlson Hope", description, 53.483, -2.2446, "Manchester, U.K."));
    myList.add(new StudentInterviewer(
        "David Mathhias", description, 50.9096, -1.40435, "Southampton, U.K"));
    myList.add(new StudentInterviewer(
        "Sasha Thomas", description, 39.18, -76.38, "Baltimore, MD"));
    myList.add(new StudentInterviewer(
        "Serena Buttler", description, 39.8, -84.30, "Cincinnati, OH"));
    myList.add(new StudentInterviewer(
        "Davey Archer", description, 41.28, -81.37, "Cleveland, OH"));
    myList.add(new StudentInterviewer(
        "Himanshu Singh", description, 40.0, -83.1, "Columbus, OH"));
    myList.add(new StudentInterviewer(
        "David Friar", description, 42.70, -73.45, "Albuquerque, NM"));
    myList.add(new StudentInterviewer(
        "Khalid Waleesi", description, 43.7735, -79.5019, "Toronto, Canda"));
    setImagePath(myList);
    setDistances(myList);
    return myList;
  }

  List<StudentInterviewer> getList() {
    if (!built) {
      list.add(new StudentInterviewer(
          "Catherine Smith", description, 33.74, -84.388, "Atlanta, GA"));
      list.add(new StudentInterviewer(
          "Dana Hudson", description, 42.331, -83.0458, "Detroit, MI"));
      list.add(new StudentInterviewer("Carla Jane", description, 34.0708781,
          -118.44684973, "Los Angeles, CA"));
      list.add(new StudentInterviewer(
          "Emma Carlson", description, 40.7128, -74.0060, "New York"));
      list.add(new StudentInterviewer(
          "Amy Carlos", description, 37.3541, -121.9552, "Santa Clara, CA"));
      list.add(new StudentInterviewer(
          "Sasha Wayne", description, 47.7511, -120.7401, "Seattle, WA"));
      list.add(new StudentInterviewer(
          "Andrea Hooper", description, 40.6331, -89.3985, "Galena, IL"));
      list.add(new StudentInterviewer(
          "Jerry Smith", description, 33.0918, -96.6989, "Plano, TX"));
      list.add(new StudentInterviewer(
          "Shawn Gomes", description, 27.6648, -81.5158, "Miami, FL"));
      list.add(new StudentInterviewer(
          "Dave Watson", description, 49.54, -97.7, "Winnipeg, Canada"));
      list.add(new StudentInterviewer(
          "Richard Jones", description, 49.13, -123.06, "Vancouver, Canada"));
      list.add(new StudentInterviewer("Tom Smith", description, 37.87122017,
          -122.25928187, "Berkeley, CA"));
      list.add(new StudentInterviewer(
          "Jennifer Wang", description, 40.27, -79.57, "Pittsburgh, PA"));
      list.add(new StudentInterviewer(
          "James Anthony", description, 45.24, -75.43, "Ottawa, Canada"));
      list.add(new StudentInterviewer(
          "Derrick Shaw", description, 39.57, -75.10, "Philadelphia, PA"));
      list.add(new StudentInterviewer(
          "Brad Simpson", description, 29.57, -90.4, "New Orleans, Louisiana"));
      list.add(new StudentInterviewer(
          "Shawn Ng", description, 43.2, -81.34, "Ontario, Canada"));
      list.add(new StudentInterviewer(
          "Code Knope", description, 33.46, -118.11, "Long Beach, CA"));
      list.add(new StudentInterviewer(
          "James Hart", description, 34.3, -118.15, "Los Angeles, CA"));
      list.add(new StudentInterviewer(
          "Kris Luo", description, 45.30, -73.35, "Montreal, Canada"));
      list.add(new StudentInterviewer(
          "Winston Reid", description, 51.38, -2.36, "Bath, U.K."));
      list.add(new StudentInterviewer(
          "Jared Buttler", description, 51.5098, -0.1180, "London, U.K."));
      list.add(new StudentInterviewer(
          "Carlson Hope", description, 53.483, -2.2446, "Manchester, U.K."));
      list.add(new StudentInterviewer("David Mathhias", description, 50.9096,
          -1.40435, "Southampton, U.K"));
      list.add(new StudentInterviewer(
          "Sasha Thomas", description, 39.18, -76.38, "Baltimore, MD"));
      list.add(new StudentInterviewer(
          "Serena Buttler", description, 39.8, -84.30, "Cincinnati, OH"));
      list.add(new StudentInterviewer(
          "Davey Archer", description, 41.28, -81.37, "Cleveland, OH"));
      list.add(new StudentInterviewer(
          "Himanshu Singh", description, 40.0, -83.1, "Columbus, OH"));
      list.add(new StudentInterviewer(
          "David Friar", description, 42.70, -73.45, "Albuquerque, NM"));
      list.add(new StudentInterviewer(
          "Khalid Waleesi", description, 43.7735, -79.5019, "Toronto, Canda"));
      setImagePath(list);
      setUnis(list);
      setPrices(list);
      setDistances(list);
      built = true;
    }
    return list;
  }

  @override
  _StudentInterviewingState createState() {
    return _StudentInterviewingState(getList());
  }
}

class _StudentInterviewingState extends State<StudentInterviewing> {
  List<StudentInterviewer> list;
  String description =
      "I have experience with UCAS, Common App and Canada admissions. Looking forward to helping all of you guys";

  _StudentInterviewingState(List<StudentInterviewer> list) {
    this.list = list;
  }

  double distanceCalculation(
      double lat1, double lon1, double lat2, double lon2) {
    final int radius = 6371;
    double latDistance = degreesToRadians(lat2 - lat1);
    double lonDistance = degreesToRadians(lon2 - lon1);
    double vbl = sin(latDistance / 2) * sin(latDistance / 2);
    vbl += (cos(degreesToRadians(lat1)) *
        cos(degreesToRadians(lat2)) *
        sin(lonDistance / 2) *
        sin(lonDistance / 2));
    double vbl2 = 2 * atan2(sqrt(vbl), sqrt(1 - vbl));
    double distance = radius * vbl2;
    return distance / 1.6;
  }

  double degreesToRadians(double degree) {
    return (degree * pi / 180.0);
  }

  double radiansToDegrees(double radians) {
    return (radians * 180 / pi);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(list.length);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('');
        DocumentSnapshot ds = snapshot.data.documents[0];
        return Stack(children: <Widget>[
          ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: <Widget>[
                  if (index == 0)
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  if (index == 0)
                    Text('Meet student interviewers close to you!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF68c1e7),
                          fontSize: 30,
                        )),
                  if (distanceCalculation(
                          list[index].latitude,
                          list[index].longitude,
                          ds['latitude'],
                          ds['longitude']) <
                      350)
                    SizedBox(height: SizeConfig.blockSizeVertical * 2.5),
                  if (distanceCalculation(
                          list[index].latitude,
                          list[index].longitude,
                          ds['latitude'],
                          ds['longitude']) <
                      350)
                    SlimyCard(
                      color: Color(0xFF68c1e7),
                      topCardHeight: SizeConfig.blockSizeVertical * 45,
                      width: SizeConfig.blockSizeHorizontal * 82,
                      topCardWidget: topCardWidget(
                          list[index].imagePath,
                          list[index].name,
                          list[index].university,
                          list[index].location,
                          distanceCalculation(
                              list[index].latitude,
                              list[index].longitude,
                              ds['latitude'],
                              ds['longitude'])),
                      bottomCardWidget: bottomCardWidget2(list[index].name),
                      bottomCardWidget1: bottomCardWidget(
                          context, list[index].name, list[index].imagePath),
                      bottomCardWidget2:
                          bottomCardWidget2(list[index].description),
                      bottomCardWidget3: bottomCardWidget3(
                          list[index].pricing.toString() + " \$ per hour"),
                    ),
                ]);
              }),
        ]);
      },
    );
  }

  // This widget will be passed as Top Card's Widget.
  Widget topCardWidget(String imagePath, String name, String university,
      String location, double distance) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: SizeConfig.blockSizeVertical * 25,
          width: SizeConfig.blockSizeVertical * 25,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage(imagePath)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          university,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
//          SizedBox(width: SizeConfig.blockSizeHorizontal * 8),
          Icon(Icons.location_on, color: Colors.white),
          Text((distance).toStringAsFixed(0) + ' miles away - ' + location,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ))
        ]),
        SizedBox(height: 15),
      ],
    );
  }

  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  // This widget will be passed as Bottom Card's Widget.
  Widget bottomCardWidget(BuildContext context, String name, String image) {
    initializeDateFormatting();
    return CalendarTimeline(
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      onDateSelected: (date) {
        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
              image: image,
              date: date,
              title: "Schedule Interview",
              name: name,
              buttonText: "Okay",
              description: "Schedule Interview",
            ),
          );
          _selectedDate = date;
        });
      },
      leftMargin: 20,
      monthColor: Colors.white70,
      dayColor: Colors.white,
      dayNameColor: Color(0xFF333A47),
      activeDayColor: Colors.white,
      activeBackgroundDayColor: Colors.redAccent[100],
      dotsColor: Color(0xFF333A47),
      selectableDayPredicate: (date) =>
          date.day != 23 && date.day != 24 && date.day != 15 && date.day != 10,
      locale: 'en',
    );
  }

  Widget bottomCardWidget2(String description) {
    return Text(
      description,
      style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic),
      textAlign: TextAlign.center,
    );
  }

  Widget bottomCardWidget3(String description) {
    return Text(
      description,
      style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic),
      textAlign: TextAlign.center,
    );
  }
}
