import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

import '../feature_pages/screen_sizes.dart';
import 'registration_confirmation.dart';

void main() {
  runApp(ThirdRoute());
}

var globalcontext;

class ThirdRoute extends StatelessWidget {
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

class Country {
  String name;
  String flag;
  bool isSelected;

  Country(this.name, this.flag, this.isSelected);
}

class CustomRadio extends StatelessWidget {
  Country _country;

  CustomRadio(this._country);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: _country.isSelected ? Color(0xFF68c1e7) : Colors.white,
        child: Container(
          height: 100,
          width: 60,
          alignment: Alignment.center,
          margin: new EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flag(
                _country.flag,
                height: 40,
              ),
              SizedBox(height: 10),
              Text(
                _country.name,
                style: TextStyle(
                    color: _country.isSelected ? Colors.white : Colors.grey,
                    fontFamily: 'Ubuntu',
                    fontSize: 16),
              )
            ],
          ),
        ));
  }
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate;
  final collegesKey = new GlobalKey<FormState>();
  List<Country> countries = new List<Country>();

  @override
  void initState() {
    super.initState();
    countries.add(new Country("U.S.A.", 'US', false));
    countries.add(new Country("Canada", 'CA', false));
    countries.add(new Country("U.K.", 'GB', false));
  }


  String selectedCountry() {
    if (countries[0].isSelected) return countries[0].name;
    if (countries[1].isSelected) return countries[1].name;
    if (countries[2].isSelected) return countries[2].name;
    return null;
  }

  final Location location = Location();
  LocationData _location;
  String _error;

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
    });
    try {
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _location = _locationResult;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('colleges')
            .where('nation', isEqualTo: selectedCountry())
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading');
          List<dynamic> dataSource = new List<dynamic>();
          for (int i = 0; i < snapshot.data.documents.length; i++) {
            DocumentSnapshot ds = snapshot.data.documents[i];
            List<String> data = [ds['name'], ds['image']];
            dataSource.add({'display': ds['name'], 'value': data});
          }
          return Center(
              child: Column(children: <Widget>[
            SizedBox(height: SizeConfig.blockSizeVertical * 20),
            Text('About your Dream University',
                style: TextStyle(
                    color: Color(0xFF68c1e7),
                    fontSize: 25,
                    fontFamily: 'Ubuntu')),
            SizedBox(height: SizeConfig.blockSizeVertical * 10),
            Text('Where do you want to study?',
                style: TextStyle(
                    color: Color(0xFF68c1e7),
                    fontSize: 20,
                    fontFamily: 'Ubuntu')),
            SizedBox(height: SizeConfig.blockSizeVertical * 4),
            Container(
                height: SizeConfig.blockSizeVertical * 20,
                width: SizeConfig.blockSizeHorizontal * 90,
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              splashColor: Color(0xFFe3f7ff),
                              onTap: () {
                                setState(() {
                                  countries[0].isSelected = true;
                                  countries[1].isSelected = false;
                                  countries[2].isSelected = false;
                                });
                              },
                              child: CustomRadio(countries[0]),
                            )),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              splashColor: Color(0xFFe3f7ff),
                              onTap: () {
                                setState(() {
                                  countries[1].isSelected = true;
                                  countries[0].isSelected = false;
                                  countries[2].isSelected = false;
                                });
                              },
                              child: CustomRadio(countries[1]),
                            )),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              splashColor: Color(0xFFe3f7ff),
                              onTap: () {
                                setState(() {
                                  countries[2].isSelected = true;
                                  countries[0].isSelected = false;
                                  countries[1].isSelected = false;
                                });
                              },
                              child: CustomRadio(countries[2]),
                            )),
                      ],
                    ),
                  ],
                )),
          ]));
        },
      ),
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
                onPressed: () async {
                  _getLocation();
                  print('Location: ' + (_error ?? '${_location ?? "unknown"}'));
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc('demouser')
                      .update({'country': selectedCountry()});
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc('demouser')
                      .update({'latitude': _location.latitude});
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc('demouser')
                      .update({'longitude': _location.longitude});
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => bookAppointmentSuccess(),
                  );
                },
                child: Icon(Icons.chevron_right),
                backgroundColor: Color(0xFF68c1e7),
              ),
            ],
          )),
    );
  }
}
