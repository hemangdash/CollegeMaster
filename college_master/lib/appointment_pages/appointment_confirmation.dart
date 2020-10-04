import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../feature_pages/screen_sizes.dart';
import 'appointment_successful.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final String image;
  String name;
  DateTime date;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.name,
    this.date,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: Color(0xFF68c1e7),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
              Align(
                alignment: Alignment.center,
                child: Text(
                    'Your interviewer is ' +
                        name +
                        '! Schedule a time that works with you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Container(
                height: SizeConfig.blockSizeVertical * 20,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(1969, 1, 1, 10, 13),
                  onDateTimeChanged: (DateTime newDateTime) {},
                  use24hFormat: false,
                  minuteInterval: 1,
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Row(children: <Widget>[
                SizedBox(width: SizeConfig.blockSizeHorizontal * 5),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: SizeConfig.blockSizeHorizontal * 25,
                        height: SizeConfig.blockSizeVertical * 5,
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          backgroundColor: Colors.red,
                          child: Text('Cancel',
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14)),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                        ))),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: SizeConfig.blockSizeHorizontal * 25,
                        height: SizeConfig.blockSizeVertical * 5,
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  bookAppointmentSuccess(
                                date: date,
                                name: name,
                              ),
                            );
                          },
                          backgroundColor: Colors.green,
                          child: Text('Book',
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14)),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                        )))
              ]),
            ],
          ),
        ),
        Positioned(
          bottom: SizeConfig.blockSizeVertical * 37.5,
          left: SizeConfig.blockSizeHorizontal * 22,
          right: SizeConfig.blockSizeHorizontal * 22,
          child: Container(
            height: SizeConfig.blockSizeVertical * 17,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(image: (AssetImage(image))),
            ),
          ),
        ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
