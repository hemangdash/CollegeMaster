library slimy_card;

import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import '../feature_pages/screen_sizes.dart';

StatusBloc slimyCard = StatusBloc();

class SlimyCard extends StatefulWidget {
  final Color color;
  final double width;
  final double topCardHeight;
  final double bottomCardHeight;
  final double borderRadius;
  final Widget topCardWidget;
  final Widget bottomCardWidget;
  final Widget bottomCardWidget1;
  final Widget bottomCardWidget2;
  final Widget bottomCardWidget3;
  final bool slimeEnabled;

  SlimyCard({
    this.color = const Color(0xff5858FF),
    this.width = 300,
    this.topCardHeight = 300,
    this.bottomCardHeight = 150,
    this.borderRadius = 25,
    this.topCardWidget,
    this.bottomCardWidget,
    this.bottomCardWidget1,
    this.bottomCardWidget2,
    this.bottomCardWidget3,
    this.slimeEnabled = true,
  })  : assert(topCardHeight >= 150, 'Height of Top Card must be atleast 150.'),
        assert(bottomCardHeight >= 100,
            'Height of Bottom Card must be atleast 100.'),
        assert(width >= 100, 'Width must be atleast 100.'),
        assert(borderRadius <= 30 && borderRadius >= 0,
            'Border Radius must neither exceed 30 nor be negative');

  @override
  _SlimyCardState createState() => _SlimyCardState();
}

class _SlimyCardState extends State<SlimyCard> with TickerProviderStateMixin {
  bool isSeperated;
  int type;
  double bottomDimension;
  double initialBottomDimension;
  double finalBottomDimension;
  double gap;
  double gapInitial;
  double gapFinal;
  double x;
  double y;
  String activeAnimation;
  Widget topCardWidget;
  Widget bottomCardWidget;
  Widget bottomCardWidget1;
  Widget bottomCardWidget2;
  Widget bottomCardWidget3;

  Animation<double> arrowAnimation;
  AnimationController arrowAnimController;

  void action() {
    if (isSeperated) {
      isSeperated = false;
      slimyCard.updateStatus(false);
      gap = gapInitial;
      bottomDimension = initialBottomDimension;
    } else {
      isSeperated = true;
      slimyCard.updateStatus(true);
      gap = gapFinal;
      bottomDimension = finalBottomDimension;
    }
    activeAnimation = (activeAnimation == 'Idle') ? 'Action' : 'Idle';
  }

  @override
  void initState() {
    super.initState();
    isSeperated = true;
    activeAnimation = 'Idle';
    initialBottomDimension = 135;
    finalBottomDimension = widget.bottomCardHeight;
    bottomDimension = initialBottomDimension;
    topCardWidget = (widget.topCardWidget != null)
        ? widget.topCardWidget
        : simpleTextWidget('This is Top Card Widget.');
    arrowAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    arrowAnimation =
        Tween<double>(begin: 0, end: 0.5).animate(arrowAnimController);
    action();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    x = (widget.borderRadius < 10) ? 10 : widget.borderRadius;
    y = (widget.borderRadius < 2) ? 2 : widget.borderRadius;
    gapInitial = ((widget.topCardHeight - x - widget.width / 4) > 0)
        ? (widget.topCardHeight - x - widget.width / 4)
        : 0;
    gapFinal = ((widget.topCardHeight + x - widget.width / 4 + 50) > 0)
        ? (widget.topCardHeight + x - widget.width / 4 + 50)
        : 2 * x + 50;
    gap = gapInitial;
  }

  @override
  void didUpdateWidget(SlimyCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      if (widget.topCardWidget != null) {
        topCardWidget = widget.topCardWidget;
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Column(
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 1800),
                height: gap,
                curve: Curves.elasticOut,
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    height: bottomDimension,
                    width: widget.width,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 100),
                      opacity: (isSeperated) ? 1.0 : 0,
                      child: bottomCardWidget,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: FlareActor(
                          'packages/slimy_card/assets/flare/bottomSlime.flr',
                          color: widget.color
                              .withOpacity((widget.slimeEnabled) ? 1 : 0),
                          animation: activeAnimation,
                          sizeFromArtboard: true,
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.contain,
                        ),
                        height: widget.width / 4,
                        width: widget.width,
                      ),
                      SizedBox(
                        height: bottomDimension - (x),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                height: widget.topCardHeight,
                width: widget.width,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: topCardWidget,
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: ((widget.topCardHeight - y) > 0)
                        ? (widget.topCardHeight - y)
                        : 0,
                  ),
                  Container(
                    height: widget.width / 4,
                    width: widget.width,
                    child: FlareActor(
                      'packages/slimy_card/assets/flare/topSlime.flr',
                      color: widget.color
                          .withOpacity((widget.slimeEnabled) ? 1 : 0),
                      animation: activeAnimation,
                      sizeFromArtboard: true,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: ((widget.topCardHeight - 2 * 50 / 3) > 0)
                    ? (widget.topCardHeight - 2 * 50 / 3)
                    : 0,
              ),
              Container(
                  width: SizeConfig.blockSizeHorizontal * 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(flex: 1, child: SizedBox(width: 10)),
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (type == 1) {
                                    action();
                                  } else {
                                    type = 1;
                                    activeAnimation = 'Action';
                                    bottomCardWidget = widget.bottomCardWidget1;
                                    if (isSeperated) {
                                      isSeperated = false;
                                    }
                                    action();
                                  }
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                child: RotationTransition(
                                  turns: arrowAnimation,
                                  child: Icon(Icons.schedule,
                                      color: Colors.black, size: 35),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.color.withOpacity(0.3),
                                      blurRadius: 20,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ))),
                      Expanded(flex: 1, child: SizedBox(width: 10)),
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (type == 2) {
                                    action();
                                  } else {
                                    activeAnimation = 'Action';
                                    if (isSeperated) {
                                      isSeperated = false;
                                    }
                                    type = 2;
                                    bottomCardWidget = widget.bottomCardWidget2;
                                    action();
                                  }
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                child: RotationTransition(
                                  turns: arrowAnimation,
                                  child: Icon(Icons.person,
                                      color: Colors.black, size: 35),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.color.withOpacity(0.3),
                                      blurRadius: 20,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ))),
                      Expanded(flex: 1, child: SizedBox(width: 10)),
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (type == 3) {
                                    action();
                                  } else {
                                    type = 3;
                                    activeAnimation = 'Action';
                                    if (isSeperated) {
                                      isSeperated = false;
                                    }
                                    bottomCardWidget = widget.bottomCardWidget3;
                                    action();
                                  }
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                child: RotationTransition(
                                  turns: arrowAnimation,
                                  child: Icon(Icons.attach_money,
                                      color: Colors.black, size: 35),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.color.withOpacity(0.3),
                                      blurRadius: 20,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ))),
                      Expanded(flex: 1, child: SizedBox(width: 10))
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

Widget simpleTextWidget(String text) {
  return Center(
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

class StatusBloc {
  var statusController = StreamController<bool>.broadcast();

  Function(bool) get updateStatus => statusController.sink.add;

  Stream<bool> get stream => statusController.stream;

  dispose() {
    statusController?.close();
  }
}
