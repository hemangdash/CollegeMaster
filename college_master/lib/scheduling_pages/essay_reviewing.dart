import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../feature_pages//screen_sizes.dart';
import '../uploading_pages/uploading_confirmation.dart';
import 'EssayReviewer.dart';

var globalcontext;

class EssayReviewing extends StatelessWidget {
  void setOrg(List<EssayReviewer> list) {
    List<String> listOrg = new List<String>();
    int tracker = -1;
    listOrg.add("The College Academy");
    listOrg.add("Atlanta Essay Consultants");
    listOrg.add("Regional University Expert");
    listOrg.add("Trusted Essayer");
    listOrg.add("University Hacker");
    listOrg.add("IvyHacks");
    for (int i = 0; i < list.length; i++) {
      tracker++;
      if (tracker > 5) {
        tracker = 0;
      }
      list[i].organization = listOrg[tracker];
    }
  }

  void setImagePath(List<EssayReviewer> list) {
    for (int i = 0; i < list.length; i++) {
      list[i].imagePath = "images/image" + (i + 1).toString() + ".png";
    }
  }

  void sortList(List<EssayReviewer> list) {
    list.sort((b, a) => a.rating.compareTo(b.rating));
  }

  @override
  Widget build(BuildContext context) {
    List<EssayReviewer> list = new List<EssayReviewer>();
    list.add(new EssayReviewer("Catherine Smith", 4.2, "US", 48, "U.S.A."));
    list.add(new EssayReviewer("Dana Hudson", 4, "GB", 39, "U.K."));
    list.add(new EssayReviewer("Carla Jane", 3, "US", 20, "U.S.A."));
    list.add(new EssayReviewer("Emma Carlson", 3.5, "GB", 37, "U.K."));
    list.add(new EssayReviewer("Amy Carlos", 4.1, "US", 29, "U.S.A."));
    list.add(new EssayReviewer("Sasha Wayne", 3.2, "GB", 130, "U.K."));
    list.add(new EssayReviewer("Andrea Hooper", 3.5, "CA", 120, "Canada"));
    list.add(new EssayReviewer("Jerry Smith", 5, "GB", 192, "U.K."));
    list.add(
        new EssayReviewer("Shawn Gomes", 4.2, "CA", 32, "Canada"));
    list.add(new EssayReviewer("Dave Watson", 5, "GB", 29, "U.K."));
    list.add(new EssayReviewer("Richard Jones", 4.0, "CA", 89, "Canada"));
    list.add(new EssayReviewer("Tom Smith", 3.5, "GB", 83, "U.K."));
    list.add(new EssayReviewer("Jennifer Wang", 2.8, "CA", 73, "Canada"));
    list.add(new EssayReviewer("James Anthony", 5.0, "CA", 64, "Canada"));
    list.add(new EssayReviewer("Derrick Shaw", 5.1, "CA", 62, "Canada"));
    list.add(new EssayReviewer("Brad Simpson", 3.8, "US", 47, "U.S.A."));
    list.add(new EssayReviewer("Shawn Ng", 2.9, "US", 129, "U.S.A."));
    list.add(new EssayReviewer("Code Knope", 3.8, "CA", 131, "Canada"));
    list.add(new EssayReviewer("James Hart", 4.1, "US", 100, "U.S.A."));
    list.add(new EssayReviewer("Kris Luo", 2.9, "US", 49, "U.S.A."));
    list.add(new EssayReviewer("Winston Reid", 3.7, "GB", 31, "U.K."));
    list.add(new EssayReviewer("Jared Buttler", 4.9, "CA", 21, "Canada"));
    list.add(new EssayReviewer("Carlson Hope", 5.0, "CA", 216, "Canada"));
    list.add(new EssayReviewer("David Mathhias", 1.9, "US", 7, "U.S.A."));
    list.add(new EssayReviewer("Sasha Thomas", 4.9, "CA", 32, "Canada"));
    list.add(new EssayReviewer("Serena Buttler", 4.8, "CA", 41, "Canada"));
    list.add(new EssayReviewer("Davey Archer", 4.6, "US", 98, "U.S.A."));
    list.add(new EssayReviewer("Himanshu Singh", 4.4, "CA", 41, "Canada"));
    list.add(new EssayReviewer("David Friar", 3.4, "GB", 42, "U.K."));
    list.add(new EssayReviewer("Khalid Waleesi", 3.9, "US", 59, "U.S.A."));
    setImagePath(list);
    setOrg(list);
    sortList(list);
    globalcontext = context;
    SizeConfig().init(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('');
        DocumentSnapshot ds = snapshot.data.documents[0];
        return Stack(
          children: <Widget>[
            ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: <Widget>[
                    if (index == 0)
                      SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    if (index == 0)
                      Text('Review your essays with our specialized experts!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF68c1e7),
                            fontSize: 30,
                          )),
                    if (list[index].countryOfSpecialization == ds['country'])
                      SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                    if (list[index].countryOfSpecialization == ds['country'])
                      buildEssayCard(
                          list[index].name,
                          list[index].organization,
                          list[index].imagePath,
                          list[index].rating,
                          list[index].essaysReviewed,
                          list[index].nationality),
                  ]);
                })
          ],
        );
      },
    );
  }

  Widget buildEssayCard(String name, String organization, String imagePath,
      double rating, int reviews, String nationality) {
    return InkWell(
        onTap: () {
          showDialog(
            context: globalcontext,
            builder: (BuildContext context) => CustomDialog2(
              image: imagePath,
              title: "Upload Essay",
              name: name,
              buttonText: "Okay",
              description: "Schedule Interview",
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.only(left: 35, right: 35),
          height: SizeConfig.blockSizeVertical * 55,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Color(0xFF68c1e7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: SizeConfig.blockSizeVertical * 22,
                    width: SizeConfig.blockSizeVertical * 22,
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
                        shadows: [Shadow(blurRadius: 1.5)]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    organization,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Container(
                      child: SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {},
                          starCount: 5,
                          rating: rating,
                          size: 35.0,
                          isReadOnly: true,
                          color: Colors.white,
                          borderColor: Colors.white,
                          spacing: 0.0)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "25\$",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 3.25 * SizeConfig.blockSizeVertical,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Price",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 2.5 * SizeConfig.blockSizeVertical,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 7.5),
                      Column(
                        children: <Widget>[
                          Text(
                            reviews.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 3.25 * SizeConfig.blockSizeVertical,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Reviewed",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 2.5 * SizeConfig.blockSizeVertical,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 7.5),
                      Column(
                        children: <Widget>[
                          Container(
                            child: Flag(
                              nationality,
                              height: SizeConfig.blockSizeVertical * 5.0,
                              width: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
