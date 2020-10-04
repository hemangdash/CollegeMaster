import 'package:college_master/scheduling_pages/essay_reviewing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'chat_screens/messaging.dart';
import 'discover_pages/discover.dart';
import 'feature_pages/footer/navigation_bar.dart';
import 'feature_pages/footer/navigation_bar_item.dart';
import 'feature_pages/screen_sizes.dart';
import 'scheduling_pages/essay_reviewing.dart';
import 'scheduling_pages/student_interviewer_map.dart';
import 'scheduling_pages/student_interviewing.dart';
import 'tray/tray.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class App extends StatelessWidget {
  static final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  static Future<FirebaseApp> getInit() {
    return _initialization;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          return MyApp();
        });
  }
}

class MyApp extends StatelessWidget {
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
    return MaterialApp(
      title: 'CollegeMaster',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF68c1e7, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'CollegeMaster'),
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
  int _currentIndex = 1;
  StudentInterviewing interviewer = new StudentInterviewing();
  EssayReviewing reviewer = new EssayReviewing();

  final List<Widget> _children = [
    EssayReviewing(),
    DiscoverPage(),
    StudentInterviewing(),
  ];

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
            Icons.person,
            color: Colors.white,
            size: SizeConfig.blockSizeHorizontal * 8,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, anotherAnimation) {
                    return Messaging();
                  }));
                },
                child: Icon(Icons.local_post_office,
                    color: Colors.white,
                    size: SizeConfig.blockSizeHorizontal * 8),
              ))
        ],
      ),
      drawer: StylishDrawer(context),
      body: _children[_currentIndex],
      bottomNavigationBar: TitledBottomNavigationBar(
        activeColor: Color(0xFF68c1e7),
        currentIndex: _currentIndex,
        inactiveColor: Colors.grey,
        inactiveStripColor: Colors.white,
        indicatorColor: Color(0xFF68c1e7),
        enableShadow: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          TitledNavigationBarItem(icon: FontAwesomeIcons.pencilAlt),
          TitledNavigationBarItem(icon: FontAwesomeIcons.search),
          TitledNavigationBarItem(icon: FontAwesomeIcons.clock),
        ],
      ),
      floatingActionButton: (_currentIndex == 2)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, anotherAnimation) {
                      return StudentMap();
                    },
                    transitionDuration: Duration(milliseconds: 300),
                    transitionsBuilder:
                        (context, animation, anotherAnimation, child) {
                      animation = CurvedAnimation(
                          curve: Curves.linear, parent: animation);
                      return SlideTransition(
                        position: Tween(
                                begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                        child: child,
                      );
                    }));
              },
              child: Container(
                width: SizeConfig.blockSizeVertical * 6.5,
                height: SizeConfig.blockSizeVertical * 6.5,
                decoration: BoxDecoration(
                    color: Color(0xFF68c1e7),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('images/earth.png'),
                        fit: BoxFit.cover),
                    boxShadow: []),
              ),
            )
          : Container(),
    );
  }
}
