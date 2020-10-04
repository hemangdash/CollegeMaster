import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../feature_pages/screen_sizes.dart';

var globalcontext;

class CollegeApp2 extends StatelessWidget {
  String collegeId;

  CollegeApp2(String collegeId) {
    this.collegeId = collegeId;
  }

  @override
  Widget build(BuildContext context) {
    globalcontext = context;
    return MaterialApp(
      title: 'Register Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CollegeProfile(
        title: 'UNI-T',
        collegeId: collegeId,
      ),
    );
  }
}

class CollegeProfile extends StatefulWidget {
  CollegeProfile({Key key, this.title, this.collegeId}) : super(key: key);

  final String title;
  final String collegeId;

  @override
  _CollegeProfileState createState() => _CollegeProfileState(collegeId);
}

class _CollegeProfileState extends State<CollegeProfile> {
  String collegeId;

  _CollegeProfileState(String collegeId) {
    this.collegeId = collegeId;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
      body: Profile(1, collegeId),
    );
  }
}

class Profile extends StatelessWidget {
  int type;
  String collegeId;

  Profile(int type, String college_id) {
    this.type = type;
    this.collegeId = college_id;
  }

  DocumentSnapshot document;
  var collegedata;

  void getDocument() async {
    document = await FirebaseFirestore.instance
        .collection('colleges')
        .doc(collegeId)
        .get();
    collegedata = document.data();
  }

  static const String apply_website = 'https://admission.gatech.edu/apply';
  static const String cost_website =
      'https://finaid.gatech.edu/current-cost-overview';
  String college_picture = 'images/georgiatech.jpg';
  String college_logo = 'images/georgiatech_logo.jpg';
  String name = 'Georgia Institute of Technology';
  String city = 'Atlanta';
  String state = 'Georgia';
  String country = 'U.S.A.';
  String major = 'Computer Science';
  int overall_average_salary = 68000;
  int major_average_salary = 90000;
  double acceptance_rate = 22;
  int tuition = 31370;
  String currency = '\$';
  int ranking = 72;
  int sat_25 = 1390;
  int sat_75 = 1540;
  int act_25 = 31;
  int act_75 = 34;
  List<String> alumni_names = [
    'Aman Advani',
    'Hemang Dash',
    'Sasikumaran Nandakumar',
    'Pranav Isaac Thomas'
  ];
  List<String> alumni_job_titles = [
    'CEO, Google',
    'CTO, Google',
    'COO, Microsoft',
    'CFO, Apple'
  ];
  List<String> alumni_images = [
    'images/aman.png',
    'images/hemang.png',
    'images/sasi.png',
    'images/pranav.png'
  ];
  List<String> college_pictures = [
    'images/georgia_tech_1.png',
    'images/georgia_tech_2.jpg',
    'images/georgia_tech_3.png',
    'images/georgia_tech_4.jpg',
    'images/georgia_tech_5.jpg',
  ];
  List<String> famous_startups = [
    'images/georgia_tech_startup_1.jpg',
    'images/georgia_tech_startup_2.jpg',
    'images/georgia_tech_startup_3.png',
    'images/georgia_tech_startup_4.png',
  ];
  List<String> famous_startups_names = [
    'Waffle House',
    'The Varsity',
    'Citrix',
    'Internet Security Systems'
  ];
  String faculty_student_ratio = '1 : 21';
  String female_male_ratio = '38 : 62';
  double retention_rate = 97;
  List<String> testimonials = [
    '\"For me, deciding to attend the Woodruff School at Georgia Tech was a rather easy decision. The consistently high academic rankings, its location in Atlanta, and its excellent reputation for graduating minorities engineering students all made GT my top choice.\" - Jamal Wilson',
    '\"The student body is composed of a group of competent, dedicated students. The graduate students, in particular, seemed to be very focused, intelligent individuals. The facilities are very accommodating. The school is constantly upgrading with new buildings, equipment, etc. The older buildings on campus are all being renovated or replaced. Computers required to simulate complex models and laboratory equipment are kept current.\" - Kimberly A. Burns',
    '\"After arriving on campus, it was clear I had made the right decision. Not only were the facilities top-notch, but they were continuously being updated and improved. The professors were accessible and involved. Occasionally they would show up at student parties, but more often you would find yourself invited to their homes. There was a great camaraderie among the students. There was always someone close by that could help you through a problem.\" - Rebecca Brown',
  ];
  List<String> companies_that_hire = [
    'images/georgia_tech_company_1.jpg',
    'images/georgia_tech_company_2.jpg',
    'images/georgia_tech_company_3.png',
    'images/georgia_tech_company_4.jpg',
    'images/georgia_tech_company_5.png',
  ];
  List<String> companies_that_hire_names = [
    'Apple',
    'Amazon',
    'Facebook',
    'Google',
    'Microsoft'
  ];

  @override
  Widget build(BuildContext context) {
    getDocument();
    return _Profile(
        context,
        college_picture,
        college_logo,
        name,
        city,
        state,
        country,
        acceptance_rate,
        tuition,
        currency,
        sat_25,
        sat_75,
        act_25,
        act_75,
        major,
        overall_average_salary,
        major_average_salary,
        alumni_names,
        alumni_images,
        alumni_job_titles,
        college_pictures,
        famous_startups,
        famous_startups_names,
        retention_rate,
        faculty_student_ratio,
        female_male_ratio,
        testimonials,
        companies_that_hire,
        companies_that_hire_names);
  }

  Widget _Profile(
      BuildContext context,
      String college_picture,
      String college_logo,
      String name,
      String city,
      String state,
      String country,
      double acceptance_rate,
      int tuition,
      String currency,
      int sat_25,
      int sat_75,
      int act_25,
      int act_75,
      String major,
      int overall_average_salary,
      int major_average_salary,
      List<String> alumni_names,
      List<String> alumni_images,
      List<String> alumni_job_titles,
      List<String> college_pictures,
      List<String> famous_companies,
      List<String> famous_companies_names,
      double retention_rate,
      String faculty_student_ratio,
      String female_male_ratio,
      List<String> testinomials,
      List<String> companies_that_hire,
      List<String> companies_that_hire_names) {
    SizeConfig().init(context);
    String acceptance = acceptance_rate.toString() + '%';
    String retention = retention_rate.toString() + '%';
    String average_tuition = currency + tuition.toString();
    String sat = sat_25.toString() + ' - ' + sat_75.toString();
    String act = act_25.toString() + ' - ' + act_75.toString();
    List<String> scores = [sat, act];
    List<String> scores_text = ['Average SAT', 'Average ACT'];
    String overall_salary = '\$' + overall_average_salary.toString();
    String major_salary = '\$' + major_average_salary.toString();
    List<String> salaries = [overall_salary, major_salary];
    List<String> salaries_text = [
      'Average Overall\nStarting Salary',
      'Average ' + major + '\nStarting Salary'
    ];

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('colleges')
          .doc(collegeId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Loading');
        var collegeDoc = snapshot.data;

        return CustomScrollView(slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Stack(
              children: <Widget>[
                Container(
                  height: 200,
                ),
                ClipPath(
                    clipper: CustomClipPath1(),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(collegeDoc['image']),
                            //image: AssetImage(college_picture),
                            //image: NetworkImage(collegedata['image']),
                            alignment: FractionalOffset.topCenter,
                            fit: BoxFit.fitWidth),
                      ),
                    )),
                Column(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.blockSizeVertical * 7),
                    Container(
                      width: SizeConfig.screenHeight / 5,
                      height: SizeConfig.screenHeight / 5,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(collegeDoc['logo']),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(blurRadius: 7.0, color: Colors.black)
                          ]),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                    Text(
                      collegeDoc['name'],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeVertical * 2.85,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(blurRadius: 1.5)]),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical),
                    Text(
                      collegeDoc['city'] +
                          ', ' +
                          collegeDoc['state'] +
                          ', ' +
                          collegeDoc['nation'],
                      style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeVertical * 2.5),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical),
                    Stack(children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(height: SizeConfig.blockSizeVertical * 2),
                          ClipPath(
                            clipper: CustomClipPath2(),
                            child: Container(
                                height: SizeConfig.blockSizeVertical * 194,
                                decoration: BoxDecoration(
                                    color: Color(0xFF68c1e7),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 20.0, color: Colors.black)
                                    ])),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(height: SizeConfig.blockSizeVertical * 3.23),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 29),
                              Container(
                                  child: Center(
                                      child: Container(
                                          width: 5,
                                          height: SizeConfig.blockSizeVertical *
                                              15.62,
                                          color: Colors.white))),
                              SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 40),
                              Container(
                                  child: Center(
                                      child: Container(
                                          width: 5,
                                          height: SizeConfig.blockSizeVertical *
                                              15.62,
                                          color: Colors.white))),
                            ],
                          ),
                          SizedBox(height: 1),
                          Center(
                              child: Container(
                                  width: 5,
                                  height: (SizeConfig.screenHeight < 730)
                                      ? SizeConfig.blockSizeVertical * 17.3
                                      : SizeConfig.blockSizeVertical * 15.5,
                                  color: Colors.white)),
                          SizedBox(height: SizeConfig.blockSizeVertical * 37.2),
                          Center(
                              child: Container(
                                  width: 5,
                                  height: (SizeConfig.screenHeight < 730)
                                      ? SizeConfig.blockSizeVertical * 17.3
                                      : SizeConfig.blockSizeVertical * 33.2,
                                  color: Colors.white)),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 32),
                              Container(
                                  child: Center(
                                      child: Container(
                                          width: 5,
                                          height:
                                              SizeConfig.blockSizeVertical * 11,
                                          color: Colors.white))),
                              SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 34),
                              Container(
                                  child: Center(
                                      child: Container(
                                          width: 5,
                                          height:
                                              SizeConfig.blockSizeVertical * 11,
                                          color: Colors.white))),
                            ],
                          ),
                          Center(
                              child: Container(
                                  width: 5,
                                  height: (SizeConfig.screenHeight < 730)
                                      ? SizeConfig.blockSizeVertical * 17.3
                                      : SizeConfig.blockSizeVertical * 80.2,
                                  color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                              height: 50,
                              width: 100,
                              child: Card(
                                  color: Color(0xFF68c1e7),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  child: GestureDetector(
                                      onTap: _launchApply,
                                      child: Center(
                                        child: Text('Apply',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Ubuntu',
                                                fontSize: 18),
                                            textAlign: TextAlign.center),
                                      )))),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2.7),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text(acceptance,
                                          style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      4)))),
                              Expanded(
                                  flex: 4,
                                  child: GestureDetector(
                                      onTap: _launchCost,
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text(average_tuition,
                                              style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical *
                                                      4))))),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text(ranking.toString(),
                                          style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      4))))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text('Acceptance\nRate',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.7))),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                        onTap: _launchCost,
                                        child: Column(children: <Widget>[
                                          Text('Average Tuition',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  color: Colors.white,
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical *
                                                      1.7)),
                                          Text('(Tap to know more)',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  color: Colors.white,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical *
                                                      1.4))
                                        ]))),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text('Ranking',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.7))),
                              )
                            ],
                          ),
                          SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
                          Container(height: 5, color: Colors.white),
                          Row(children: <Widget>[
                            Expanded(
                                flex: 5,
                                child: Container(
                                    height: (SizeConfig.screenHeight < 730)
                                        ? SizeConfig.blockSizeVertical * 16.72
                                        : SizeConfig.blockSizeVertical * 15,
                                    child: Swiper(
                                        itemBuilder: (context, index) {
                                          return new Column(children: <Widget>[
                                            SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    2.005),
                                            Container(
                                                height: 100,
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            1),
                                                    Text(
                                                      scores[index],
                                                      style: TextStyle(
                                                          fontSize: SizeConfig
                                                                  .blockSizeVertical *
                                                              3.7,
                                                          color: Colors.white,
                                                          fontFamily: 'Ubuntu',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      scores_text[index],
                                                      style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .blockSizeVertical *
                                                            1.7,
                                                        color: Colors.white,
                                                        fontFamily: 'Ubuntu',
                                                      ),
                                                    )
                                                  ],
                                                ))
                                          ]);
                                        },
                                        itemCount: 2,
                                        pagination: new SwiperPagination(
                                            builder:
                                                new DotSwiperPaginationBuilder(
                                                    color: Colors.white30,
                                                    activeColor: Colors.white,
                                                    size: 10.0,
                                                    activeSize: 10.0))))),
                            Expanded(
                                flex: 5,
                                child: Container(
                                    height: (SizeConfig.screenHeight < 730)
                                        ? SizeConfig.blockSizeVertical * 16.72
                                        : SizeConfig.blockSizeVertical * 15,
                                    child: Swiper(
                                        itemWidth: 100,
                                        itemBuilder: (context, index) {
                                          return new Column(children: <Widget>[
                                            SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    2.005),
                                            Container(
                                                height: 100,
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      salaries[index],
                                                      style: TextStyle(
                                                          fontSize: SizeConfig
                                                                  .blockSizeVertical *
                                                              3.7,
                                                          color: Colors.white,
                                                          fontFamily: 'Ubuntu',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      salaries_text[index],
                                                      style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .blockSizeVertical *
                                                            1.7,
                                                        color: Colors.white,
                                                        fontFamily: 'Ubuntu',
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ))
                                          ]);
                                        },
                                        itemCount: 2,
                                        pagination: new SwiperPagination(
                                            builder:
                                                new DotSwiperPaginationBuilder(
                                                    color: Colors.white30,
                                                    activeColor: Colors.white,
                                                    size: 10.0,
                                                    activeSize: 10.0)))))
                          ]),
                          Container(height: 5, color: Colors.white),
                          Container(
                              height: SizeConfig.blockSizeVertical * 36,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                      height: SizeConfig.blockSizeVertical),
                                  Text('Experience the vibe!',
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: 25,
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                      height: SizeConfig.blockSizeVertical),
                                  Container(
                                      height: 240,
                                      child: Swiper(
                                        itemBuilder: (context, index) {
                                          return new Column(
                                            children: <Widget>[
                                              Container(
                                                height: 200,
                                                width:
                                                    SizeConfig.screenWidth - 50,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            college_pictures[
                                                                index]),
                                                        fit: BoxFit.cover),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 3.0,
                                                          color: Colors.black)
                                                    ]),
                                              ),
                                            ],
                                          );
                                        },
                                        itemWidth: SizeConfig.screenWidth - 50,
                                        itemCount: 5,
                                        layout: SwiperLayout.DEFAULT,
                                        pagination: SwiperPagination(
                                            builder:
                                                new DotSwiperPaginationBuilder(
                                                    color: Colors.white30,
                                                    activeColor: Colors.white,
                                                    size: 10.0,
                                                    activeSize: 10.0)),
                                      )),
                                ],
                              )),
                          Container(height: 5, color: Colors.white),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                      height: SizeConfig.blockSizeVertical * 33,
                                      child: Column(children: <Widget>[
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical),
                                        Text('They studied here!',
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      2.5,
                                              color: Colors.white,
                                            )),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical),
                                        Container(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    28,
                                            child: Swiper(
                                              itemWidth:
                                                  SizeConfig.blockSizeVertical *
                                                      20,
                                              itemBuilder: (context, index) {
                                                return new Column(
                                                  children: <Widget>[
                                                    Container(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          17.9,
                                                      width: SizeConfig
                                                              .blockSizeVertical *
                                                          17.9,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          image:
                                                              DecorationImage(
                                                                  image: AssetImage(
                                                                      alumni_images[index]),
                                                                  fit: BoxFit.cover),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                blurRadius: 3.0,
                                                                color: Colors
                                                                    .black)
                                                          ]),
                                                    ),
                                                    SizedBox(
                                                        height: SizeConfig
                                                            .blockSizeVertical),
                                                    Text(
                                                      alumni_names[index],
                                                      style: TextStyle(
                                                        fontFamily: 'Ubuntu',
                                                        fontSize: SizeConfig
                                                                .blockSizeVertical *
                                                            2,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            0.4),
                                                    Text(
                                                      alumni_job_titles[index],
                                                      style: TextStyle(
                                                        fontFamily: 'Ubuntu',
                                                        fontSize: SizeConfig
                                                                .blockSizeVertical *
                                                            2,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                );
                                              },
                                              itemCount: 4,
                                              layout: SwiperLayout.DEFAULT,
                                              pagination: SwiperPagination(
                                                  builder:
                                                      new DotSwiperPaginationBuilder(
                                                          color: Colors.white30,
                                                          activeColor:
                                                              Colors.white,
                                                          size: 10.0,
                                                          activeSize: 10.0)),
                                            ))
                                      ]))),
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                      height: SizeConfig.blockSizeVertical * 33,
                                      child: Column(children: <Widget>[
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical),
                                        Text('They started here!',
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      2.5,
                                              color: Colors.white,
                                            )),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    0.6),
                                        Container(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    28,
                                            child: Swiper(
                                              itemWidth:
                                                  SizeConfig.blockSizeVertical *
                                                      20,
                                              itemBuilder: (context, index) {
                                                return new Column(
                                                  children: <Widget>[
                                                    Container(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          20.4,
                                                      width: SizeConfig
                                                              .blockSizeVertical *
                                                          20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                                  image: AssetImage(
                                                                      famous_companies[index]),
                                                                  fit: BoxFit.cover),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                blurRadius: 3.0,
                                                                color: Colors
                                                                    .black)
                                                          ]),
                                                    ),
                                                    SizedBox(
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            0.8),
                                                    Text(
                                                      famous_companies_names[
                                                          index],
                                                      style: TextStyle(
                                                        fontFamily: 'Ubuntu',
                                                        fontSize: SizeConfig
                                                                .blockSizeVertical *
                                                            2,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                );
                                              },
                                              itemCount: 4,
                                              layout: SwiperLayout.DEFAULT,
                                              pagination: SwiperPagination(
                                                  builder:
                                                      new DotSwiperPaginationBuilder(
                                                          color: Colors.white30,
                                                          activeColor:
                                                              Colors.white,
                                                          size: 10.0,
                                                          activeSize: 10.0),
                                                  margin: EdgeInsets.all(8)),
                                            ))
                                      ])))
                            ],
                          ),
                          Container(height: 5, color: Colors.white),
                          SizedBox(height: SizeConfig.blockSizeVertical),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text(faculty_student_ratio,
                                          style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      4)))),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text(female_male_ratio,
                                          style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      4)))),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text(retention,
                                          style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      4))))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text('Faculty : Student\nRatio',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.7))),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text('Female : Male\nRatio',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.7))),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text('Retention\nRate',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.7))),
                              )
                            ],
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical),
                          Container(height: 5, color: Colors.white),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                      height: SizeConfig.blockSizeVertical * 33,
                                      child: Column(children: <Widget>[
                                        Container(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    33,
                                            child: Swiper(
                                              itemWidth:
                                                  SizeConfig.blockSizeVertical *
                                                      20,
                                              itemBuilder: (context, index) {
                                                return new Column(
                                                  children: <Widget>[
                                                    Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            45,
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            30,
                                                        child: Center(
                                                            child: Text(
                                                          testimonials[index],
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontSize: SizeConfig
                                                                      .blockSizeVertical *
                                                                  1.7,
                                                              color:
                                                                  Colors.white),
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 14,
                                                        ))),
                                                    SizedBox(
                                                        height: SizeConfig
                                                            .blockSizeVertical),
                                                  ],
                                                );
                                              },
                                              itemCount: 3,
                                              layout: SwiperLayout.DEFAULT,
                                              pagination: SwiperPagination(
                                                  builder:
                                                      new DotSwiperPaginationBuilder(
                                                          color: Colors.white30,
                                                          activeColor:
                                                              Colors.white,
                                                          size: 10.0,
                                                          activeSize: 10.0)),
                                            ))
                                      ]))),
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                      height: SizeConfig.blockSizeVertical * 33,
                                      child: Column(children: <Widget>[
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical),
                                        Text('They hire here!',
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      2.5,
                                              color: Colors.white,
                                            )),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    0.6),
                                        Container(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    28,
                                            child: Swiper(
                                              itemWidth:
                                                  SizeConfig.blockSizeVertical *
                                                      20,
                                              itemBuilder: (context, index) {
                                                return new Column(
                                                  children: <Widget>[
                                                    Container(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          20.4,
                                                      width: SizeConfig
                                                              .blockSizeVertical *
                                                          20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                                  image: AssetImage(
                                                                      companies_that_hire[index]),
                                                                  fit: BoxFit.cover),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                blurRadius: 3.0,
                                                                color: Colors
                                                                    .black)
                                                          ]),
                                                    ),
                                                    SizedBox(
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            0.8),
                                                    Text(
                                                      companies_that_hire_names[
                                                          index],
                                                      style: TextStyle(
                                                        fontFamily: 'Ubuntu',
                                                        fontSize: SizeConfig
                                                                .blockSizeVertical *
                                                            2,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                );
                                              },
                                              itemCount: 5,
                                              layout: SwiperLayout.DEFAULT,
                                              pagination: SwiperPagination(
                                                  builder:
                                                      new DotSwiperPaginationBuilder(
                                                          color: Colors.white30,
                                                          activeColor:
                                                              Colors.white,
                                                          size: 10.0,
                                                          activeSize: 10.0),
                                                  margin: EdgeInsets.all(8)),
                                            ))
                                      ])))
                            ],
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical),
                          Container(height: 5, color: Colors.white),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                      height: SizeConfig.blockSizeVertical * 45,
                                      child: Column(children: <Widget>[
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical),
                                        Text('Major Distribution',
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      2.5,
                                              color: Colors.white,
                                            )),
                                        Container(
                                          height:
                                              SizeConfig.blockSizeVertical * 41,
                                          child: new DonutAutoLabelChart(
                                              _createMajorsData(),
                                              animate: false),
                                        )
                                      ]))),
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                      height: SizeConfig.blockSizeVertical * 45,
                                      child: Column(children: <Widget>[
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical),
                                        Text('Racial Profile',
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      2.5,
                                              color: Colors.white,
                                            )),
                                        Center(
                                            child: Container(
                                          height:
                                              SizeConfig.blockSizeVertical * 41,
                                          child: new DonutAutoLabelChart(
                                              _createRacesData(),
                                              animate: false),
                                        ))
                                      ])))
                            ],
                          ),
                        ],
                      ),
                    ]),
                  ],
                ),
              ],
            )
          ]))
        ]);
      },
    );
  }

  static List<charts.Series<LinearRaces, String>> _createRacesData() {
    final data = [
      new LinearRaces(1, 'White', 49, charts.Color.fromHex(code: '#ffd8d8')),
      new LinearRaces(2, 'Asian', 20.8, charts.Color.fromHex(code: '#ffc4c4')),
      new LinearRaces(
          3, 'Non-Resident Aliens', 9.2, charts.Color.fromHex(code: '#ffb1b1')),
      new LinearRaces(4, 'Black or African American', 6.9,
          charts.Color.fromHex(code: '#ff9d9d')),
      new LinearRaces(
          5, 'Hispanic/Latino', 6.6, charts.Color.fromHex(code: '#ff8989')),
      new LinearRaces(
          6, 'Ethnicity Unknown', 7.5, charts.Color.fromHex(code: '#ff7676')),
    ];
    return [
      new charts.Series<LinearRaces, String>(
        id: 'Sales',
        domainFn: (LinearRaces races, _) => races.race,
        measureFn: (LinearRaces races, _) => races.percentage,
        data: data,
        colorFn: (LinearRaces races, _) => races.color,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearRaces row, _) => '${row.percentage}%',
        insideLabelStyleAccessorFn: (LinearRaces row, _) =>
            charts.TextStyleSpec(
                color: charts.Color.fromHex(code: '#000000'), fontSize: 11),
      )
    ];
  }

  static List<charts.Series<LinearMajors, String>> _createMajorsData() {
    final data = [
      new LinearMajors(
          1, 'Computer Science', 49, charts.Color.fromHex(code: '#ffff00')),
      new LinearMajors(2, 'Mechanical Engineering', 20.8,
          charts.Color.fromHex(code: '#f5f50a')),
      new LinearMajors(3, 'Industrial Engineering', 9.2,
          charts.Color.fromHex(code: '#ebeb14')),
      new LinearMajors(4, 'Business Administration', 6.9,
          charts.Color.fromHex(code: '#e2e21d')),
      new LinearMajors(5, 'Environmental Engineering', 6.6,
          charts.Color.fromHex(code: '#d8d827')),
      new LinearMajors(6, 'Electrical Engineering', 7.5,
          charts.Color.fromHex(code: '#cece31')),
    ];
    return [
      new charts.Series<LinearMajors, String>(
        id: 'Sales',
        domainFn: (LinearMajors majors, _) => majors.major,
        measureFn: (LinearMajors majors, _) => majors.percentage,
        data: data,
        colorFn: (LinearMajors majors, _) => majors.color,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearMajors row, _) => '${row.percentage}%',
        insideLabelStyleAccessorFn: (LinearMajors row, _) =>
            charts.TextStyleSpec(
                color: charts.Color.fromHex(code: '#000000'), fontSize: 11),
      )
    ];
  }

  _launchApply() async {
    const url = apply_website;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchCost() async {
    const url = cost_website;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class DonutAutoLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        behaviors: [
          new charts.DatumLegend(
            position: charts.BehaviorPosition.bottom,
            outsideJustification: charts.OutsideJustification.endDrawArea,
            horizontalFirst: false,
            cellPadding: new EdgeInsets.only(right: 4.0, bottom: 8.0, top: 1),
            entryTextStyle: charts.TextStyleSpec(
                fontSize: 11,
                color: charts.Color.fromHex(code: '#ffffff'),
                fontFamily: 'Ubuntu'),
          )
        ],
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 40,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }
}

class LinearMajors {
  final int number;
  final String major;
  final double percentage;
  final charts.Color color;

  LinearMajors(this.number, this.major, this.percentage, this.color);
}

class LinearRaces {
  final int number;
  final String race;
  final double percentage;
  final charts.Color color;

  LinearRaces(this.number, this.race, this.percentage, this.color);
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
