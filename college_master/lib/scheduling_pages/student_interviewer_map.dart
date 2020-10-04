import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_master/scheduling_pages/StudentInterviewer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../feature_pages/screen_sizes.dart';
import 'map_dialog_box.dart';
import 'student_interviewing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StudentMap());
}

var globalcontext;

class MapMarker extends Clusterable {
  final String id;
  final LatLng position;
  BitmapDescriptor icon;

  MapMarker({
    @required this.id,
    @required this.position,
    @required this.icon,
    isCluster = false,
    clusterId,
    pointsSize,
    childMarkerId,
  }) : super(
          markerId: id,
          latitude: position.latitude,
          longitude: position.longitude,
          isCluster: isCluster,
          clusterId: clusterId,
          pointsSize: pointsSize,
          childMarkerId: childMarkerId,
        );

  Marker toMarker() => Marker(
        markerId: MarkerId(id),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
        icon: pinLocationIcon,
      );
}

class StudentMap extends StatefulWidget {
  @override
  _StudentMapState createState() => _StudentMapState();
}

class _StudentMapState extends State<StudentMap> {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(104, 193, 231, .1),
      100: Color.fromRGBO(104, 193, 231, .2),
      200: Color.fromRGBO(104, 193, 231, .3),
      300: Color.fromRGBO(104, 193, 231, .4),
      400: Color.fromRGBO(104, 193, 231, .5),
      500: Color.fromRGBO(104, 193, 231, .6),
      600: Color.fromRGBO(104, 193, 231, .7),
      700: Color.fromRGBO(104, 193, 231, .8),
      800: Color.fromRGBO(104, 193, 231, .9),
      900: Color.fromRGBO(104, 193, 231, 1),
    };
    globalcontext = context;
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: MaterialColor(0xFF68c1e7, color),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MapBuilder());
  }
}

class MapBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Worldwide Database',
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
      body: MapWidget(),
    );
  }
}

BitmapDescriptor pinLocationIcon;

void setCustomMapPin() async {
  pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(1, 1)), 'images/marker.png');
}

class MapWidget extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    setCustomMapPin();
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('colleges').snapshots(),
        builder: (context, snapshot) {
          var markers = <MarkerId, Marker>{};
          List<StudentInterviewer> list = StudentInterviewing().getListForMap();
          print(list);

          for (var i = 0; i < list.length; i++) {
            final markerId = MarkerId(list[i].name);
            final LatLng pos = LatLng(list[i].latitude, list[i].longitude);
            final aMarker = Marker(
                markerId: markerId,
                position: pos,
                icon: pinLocationIcon,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        print(list[i].distance);
                        return CustomDialog(
                            title: 'Schedule Interview',
                            name: list[i].name,
                            image: list[i].imagePath,
                            distance: list[i].distance,
                            location: list[i].location,
                            description: null,
                            buttonText: 'OK');
                      });
                });
            markers[markerId] = aMarker;
          }

          return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 3.0,
            ),
            markers: Set<Marker>.of(markers.values),
          );
        });
  }
}
