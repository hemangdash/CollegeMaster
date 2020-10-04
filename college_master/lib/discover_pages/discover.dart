import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_master/appointment_pages/appointment_confirmation.dart';
import 'package:college_master/search_pages/search2.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../feature_pages/screen_sizes.dart';
import '../profile_pages/college_profile.dart';
import '../search_pages/discover_bar.dart';
import '../uploading_pages/uploading_confirmation.dart';

List<List<String>> colleges = [
  ['Georgia Institute of Technology', 'images/georgia_tech_1.png'],
  ['Massachusetts Institute of Technology', 'images/georgia_tech_2.jpg'],
  ['University of Warwick', 'images/georgia_tech_3.png'],
  ['University of Western Ontario', 'images/georgia_tech_4.jpg'],
  ['London School of Economics', 'images/georgia_tech_5.jpg'],
];
List<List<String>> interviewers = [
  ['Catherine Smith', 'images/image1.png', 'Georgia Tech'],
  ['Dana Hudson', 'images/image2.png', 'Cambridge University'],
  ['Carla Jane', 'images/image3.png', 'Oxford University'],
  ['Emma Carlson', 'images/image4.png', 'Harvard University']
];
List<double> interviewers_ratings = [4, 3, 2, 1];
List<double> interviewers_prices = [15, 18, 30, 40];
List<List<String>> reviewers = [
  ['Amy Carlos', 'images/image5.png', 'The College Academy'],
  ['Sasha Wayne', 'images/image6.png', 'Atlanta Essay Consultants'],
  ['Andrea Hooper', 'images/image7.png', 'Regional University Expert'],
  ['Jerry Smith', 'images/image8.png', 'Trusted Essayer']
];
List<double> reviewers_ratings = [4, 3, 2, 1];
List<double> reviewers_prices = [100, 180, 300, 400];

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(2.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Color(0xFF68c1e7).withOpacity(0.6),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            color: (isForList) ? Colors.black : Colors.black,
            fontFamily: 'Ubuntu',
            fontSize: 18,
            fontWeight: (isForList) ? FontWeight.normal : FontWeight.bold),
      ),
    );
  }
}

var globalcontext;

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globalcontext = context;
    return Stack(
      children: <Widget>[
        Container(
            child: Column(children: <Widget>[
          SizedBox(height: SizeConfig.blockSizeVertical * 1),
          Center(
              child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => new First()));
            },
            child: Container(
              child: TextField(
                enabled: false,
                style: TextStyle(color: Color.fromRGBO(142, 142, 147, 1)),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 2.0),
                    child: Icon(Icons.search), // myIcon is a 48px-wide widget.
                  ),
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(color: Color.fromRGBO(142, 142, 147, 1)),
                ),
              ),
              width: SizeConfig.blockSizeHorizontal * 98,
              decoration: BoxDecoration(
                borderRadius: SearchBarStyle().borderRadius,
                color: SearchBarStyle().backgroundColor,
              ),
            ),
          )),
          SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
          Container(
            height: SizeConfig.blockSizeVertical * 35.2,
            width: SizeConfig.blockSizeHorizontal * 95,
            child: BuildCollegeSection(colleges),
          ),
          Container(
              height: SizeConfig.blockSizeVertical * 34,
              width: SizeConfig.blockSizeHorizontal * 95,
              child: Row(children: <Widget>[
                Container(
                    width: SizeConfig.blockSizeHorizontal * 47.5,
                    height: SizeConfig.blockSizeVertical * 35,
                    child: DiscoverPeople(
                        1,
                        interviewers,
                        reviewers,
                        interviewers_ratings,
                        interviewers_prices,
                        reviewers_ratings,
                        reviewers_prices)),
                Container(
                    width: SizeConfig.blockSizeHorizontal * 47.5,
                    height: SizeConfig.blockSizeVertical * 35,
                    child: DiscoverPeople(
                        2,
                        interviewers,
                        reviewers,
                        interviewers_ratings,
                        interviewers_prices,
                        reviewers_ratings,
                        reviewers_prices)),
              ])),
        ]))
      ],
    );
  }
}

class BuildCollegeSection extends StatefulWidget {
  String country = 'U.S.A.';
  List<List<String>> data;

  BuildCollegeSection(List<List<String>> data) {
    this.data = data;
  }

  _BuildCollegeSection createState() => _BuildCollegeSection(data);
}

class _BuildCollegeSection extends State<BuildCollegeSection> {
  String country = 'U.K.';
  List<List<String>> data;
  Widget start_arrow = new Container(width: SizeConfig.blockSizeHorizontal * 1);
  Widget end_arrow = new Container(
      width: SizeConfig.blockSizeHorizontal * 1,
      child: Center(
          child: Icon(Icons.arrow_right, color: Colors.white, size: 45)));

  _BuildCollegeSection(List<List<String>> data) {
    this.data = data;
  }

  var _controller = ScrollController(
      initialScrollOffset: SizeConfig.blockSizeHorizontal * 23.5);

  @override
  void initState() {
    super.initState();

    // set up listener here
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          setState(() {
            start_arrow = Container(width: SizeConfig.blockSizeHorizontal * 1);
          });
        } else {
          setState(() {
            end_arrow = Container(width: SizeConfig.blockSizeHorizontal * 1);
          });
        }
      } else {
        setState(() {
          start_arrow = Container(
              width: SizeConfig.blockSizeHorizontal * 1,
              child: Center(
                  child:
                      Icon(Icons.arrow_left, color: Colors.white, size: 45)));
          end_arrow = Container(
              width: SizeConfig.blockSizeHorizontal * 1,
              child: Center(
                  child:
                      Icon(Icons.arrow_right, color: Colors.white, size: 45)));
        });
      }
    });
  }

  final elements1 = ['U.S.A.', 'Canada', 'U.K.'];
  int selectedCountryIndex = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Card(
            elevation: 10,
            shadowColor: Color(0xFF68c1e7),
            color: Color(0xFF68c1e7),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Center(
                child: Column(children: <Widget>[
              Container(
                  height: SizeConfig.blockSizeVertical * 34,
                  width: SizeConfig.blockSizeHorizontal * 95,
                  child: Stack(children: <Widget>[
                    Center(
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                                height: SizeConfig.blockSizeVertical * 32,
                                width: SizeConfig.blockSizeHorizontal * 80,
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('colleges')
                                      .where('nation',
                                          isEqualTo:
                                              elements1[selectedCountryIndex])
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return Text('Loading');
                                    return ListView.separated(
                                      controller: _controller,
                                      itemCount:
                                          (country == 'U.S.A.') ? 15 : 10,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) {
                                        DocumentSnapshot ds =
                                            snapshot.data.documents[i];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                        animation,
                                                        anotherAnimation) {
                                                      return CollegeApp(ds.id);
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
                                                    40,
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
                                  },
                                )),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              width: SizeConfig.blockSizeHorizontal * 30,
                              child: DirectSelect(
                                  itemExtent: 35,
                                  selectedIndex: selectedCountryIndex,
                                  backgroundColor: Color(0xFF68c1e7),
                                  child: MySelectionItem(
                                    isForList: false,
                                    title: elements1[selectedCountryIndex],
                                  ),
                                  onSelectedItemChanged: (index) {
                                    setState(() {
                                      selectedCountryIndex = index;
                                    });
                                  },
                                  items: _buildItems1()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]))
            ]))));
  }
}

class DiscoverPeople extends StatelessWidget {
  int type;
  List<List<String>> interviewers;
  List<List<String>> reviewers;
  List<double> interviewers_ratings;
  List<double> interviewers_prices;
  List<double> reviewers_ratings;
  List<double> reviewers_prices;

  DiscoverPeople(
      int type,
      List<List<String>> interviewers,
      List<List<String>> reviewers,
      List<double> interviewers_ratings,
      List<double> interviewers_prices,
      List<double> reviewers_ratings,
      List<double> reviewers_prices) {
    this.type = type;
    this.interviewers = interviewers;
    this.reviewers = reviewers;
    this.interviewers_ratings = interviewers_ratings;
    this.interviewers_prices = interviewers_prices;
    this.reviewers_ratings = reviewers_ratings;
    this.reviewers_prices = reviewers_prices;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Card(
          elevation: 10,
          shadowColor: Color(0xFF68c1e7),
          color: Color(0xFF68c1e7),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.blockSizeVertical * 1),
              Container(
                  height: SizeConfig.blockSizeVertical * 31.8,
                  child: Swiper(
                    itemCount: 4,
                    fade: 0,
                    pagination: new SwiperPagination(
                        builder: new DotSwiperPaginationBuilder(
                            color: Colors.white70,
                            activeColor: Colors.white,
                            size: 8.0,
                            activeSize: 10.0)),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            if (type == 1) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => CustomDialog(
                                  image: interviewers[index][1],
                                  date: DateTime.now(),
                                  title: "Schedule Interview",
                                  name: interviewers[index][0],
                                  buttonText: "Okay",
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomDialog2(
                                  image: reviewers[index][1],
                                  title: "Upload Essay",
                                  name: reviewers[index][0],
                                  buttonText: "Okay",
                                ),
                              );
                            }
                          },
                          child: Stack(children: <Widget>[
                            Column(children: <Widget>[
                              Container(
                                  child: Center(
                                      child: Container(
                                padding: EdgeInsets.fromLTRB(7, 0, 7, 12),
                                width: SizeConfig.blockSizeHorizontal * 41,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xFFe3f7ff),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black, blurRadius: 0.5)
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Container(
                                      height: (SizeConfig.screenHeight > 750)
                                          ? SizeConfig.blockSizeVertical * 14
                                          : SizeConfig.blockSizeVertical * 11.5,
                                      width: (SizeConfig.screenHeight > 750)
                                          ? SizeConfig.blockSizeVertical * 14
                                          : SizeConfig.blockSizeHorizontal * 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage((type == 1)
                                                  ? interviewers[index][1]
                                                  : reviewers[index][1]),
                                              fit: BoxFit.cover),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 1)
                                          ]),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      child: Text(
                                        (type == 1)
                                            ? interviewers[index][0]
                                            : reviewers[index][0],
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.63,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      (type == 1)
                                          ? 'Student Interviewer'
                                          : 'Essay Reviewer',
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        color: Color(0xFF68c1e7),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 1.63,
                                        shadows: [
                                          Shadow(
                                              // bottomLeft
                                              offset: Offset(-0.2, -0.2),
                                              color: Colors.black),
                                          Shadow(
                                              // bottomRight
                                              offset: Offset(0.2, -0.2),
                                              color: Colors.black),
                                          Shadow(
                                              // topRight
                                              offset: Offset(0.2, 0.2),
                                              color: Colors.black),
                                          Shadow(
                                              // topLeft
                                              offset: Offset(-0.2, 0.2),
                                              color: Colors.black),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      (type == 1)
                                          ? interviewers[index][2]
                                          : reviewers[index][2],
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        color: Colors.black,
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 1.3,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 6),
                                    SmoothStarRating(
                                      allowHalfRating: true,
                                      onRated: (v) {},
                                      starCount: 5,
                                      rating: (type == 1)
                                          ? interviewers_ratings[index]
                                          : reviewers_ratings[index],
                                      size: 25,
                                      isReadOnly: true,
                                      color: Colors.black,
                                      borderColor: Colors.black,
                                    ),
                                  ],
                                ),
                              ))),
                            ]),
                            Positioned(
                                right: SizeConfig.blockSizeHorizontal * 1,
                                bottom: SizeConfig.blockSizeVertical * 3.0,
                                child: Container(
                                    height:
                                        SizeConfig.blockSizeHorizontal * 9.2,
                                    width: SizeConfig.blockSizeHorizontal * 9.2,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFe3f7ff),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 0.5)
                                        ]),
                                    child: Center(
                                        child: Text(
                                      '\$' +
                                          ((type == 1)
                                              ? interviewers_prices[index]
                                                  .round()
                                                  .toString()
                                              : reviewers_prices[index]
                                                  .round()
                                                  .toString()),
                                      style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.bold),
                                    ))))
                          ]));
                    },
                  ))
            ],
          ),
        ));
  }
}
