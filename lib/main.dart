import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class SwipeConfiguration {
  //Vertical swipe configuration options
  double verticalSwipeMaxWidthThreshold = 50.0;
  double verticalSwipeMinDisplacement = 100.0;
  double verticalSwipeMinVelocity = 300.0;
  //Horizontal swipe configuration options
  double horizontalSwipeMaxHeightThreshold = 50.0;
  double horizontalSwipeMinDisplacement = 100.0;
  double horizontalSwipeMinVelocity = 300.0;

  SwipeConfiguration({
    double? verticalSwipeMaxWidthThreshold,
    double? verticalSwipeMinDisplacement,
    double? verticalSwipeMinVelocity,
    double? horizontalSwipeMaxHeightThreshold,
    double? horizontalSwipeMinDisplacement,
    double? horizontalSwipeMinVelocity,
  }) {
    if (verticalSwipeMaxWidthThreshold != null) {
      this.verticalSwipeMaxWidthThreshold = verticalSwipeMaxWidthThreshold;
    }
    if (verticalSwipeMinDisplacement != null) {
      this.verticalSwipeMinDisplacement = verticalSwipeMinDisplacement;
    }
    if (verticalSwipeMinVelocity != null) {
      this.verticalSwipeMinVelocity = verticalSwipeMinVelocity;
    }
    if (horizontalSwipeMaxHeightThreshold != null) {
      this.horizontalSwipeMaxHeightThreshold = horizontalSwipeMaxHeightThreshold;
    }
    if (horizontalSwipeMinDisplacement != null) {
      this.horizontalSwipeMinDisplacement = horizontalSwipeMinDisplacement;
    }
    if (horizontalSwipeMinVelocity != null) {
      this.horizontalSwipeMinVelocity = horizontalSwipeMinVelocity;
    }
  }
}


class SwipeDetector extends StatelessWidget {
  final Widget child;
  final Function() onSwipeUp;
  final Function() onSwipeDown;
  final Function() onSwipeLeft;
  final Function() onSwipeRight;
  final SwipeConfiguration swipeConfiguration;

  SwipeDetector(
      {required this.child,
      required this.onSwipeUp,
      required this.onSwipeDown,
      required  this.onSwipeLeft,
      required this.onSwipeRight,
      SwipeConfiguration? swipeConfiguration})
      : this.swipeConfiguration = swipeConfiguration == null
            ? SwipeConfiguration()
            : swipeConfiguration;

  @override
  Widget build(BuildContext context) {
    //Vertical drag details
    late DragStartDetails startVerticalDragDetails;
    late DragUpdateDetails updateVerticalDragDetails;
    //Horizontal drag details
    late DragStartDetails startHorizontalDragDetails;
    late DragUpdateDetails updateHorizontalDragDetails;
    return GestureDetector(
      child: child,
      onVerticalDragStart: (dragDetails) {
        startVerticalDragDetails = dragDetails;
      },
      onVerticalDragUpdate: (dragDetails) {
        updateVerticalDragDetails = dragDetails;
      },
      onVerticalDragEnd: (endDetails) {
        double dx = updateVerticalDragDetails.globalPosition.dx -
            startVerticalDragDetails.globalPosition.dx;
        double dy = updateVerticalDragDetails.globalPosition.dy -
            startVerticalDragDetails.globalPosition.dy;
        double velocity = endDetails.primaryVelocity!;
        //Convert values to be positive
        if (dx < 0) dx = -dx;
        if (dy < 0) dy = -dy;
        double positiveVelocity = velocity < 0 ? -velocity : velocity;
        if (dx > swipeConfiguration.verticalSwipeMaxWidthThreshold) return;
        if (dy < swipeConfiguration.verticalSwipeMinDisplacement) return;
        if (positiveVelocity < swipeConfiguration.verticalSwipeMinVelocity)
          return;
        if (velocity < 0) {
          //Swipe Up
          if (onSwipeUp != null) {
            onSwipeUp();
          }
        } else {
          //Swipe Down
          if (onSwipeDown != null) {
            onSwipeDown();
          }
        }
      },
      onHorizontalDragStart: (dragDetails) {
        startHorizontalDragDetails = dragDetails;
      },
      onHorizontalDragUpdate: (dragDetails) {
        updateHorizontalDragDetails = dragDetails;
      },
      onHorizontalDragEnd: (endDetails) {
        double dx = updateHorizontalDragDetails.globalPosition.dx -
            startHorizontalDragDetails.globalPosition.dx;
        double dy = updateHorizontalDragDetails.globalPosition.dy -
            startHorizontalDragDetails.globalPosition.dy;
        double velocity = endDetails.primaryVelocity!;
        if (dx < 0) dx = -dx;
        if (dy < 0) dy = -dy;
        double positiveVelocity = velocity < 0 ? -velocity : velocity;
        if (dx < swipeConfiguration.horizontalSwipeMinDisplacement) return;
        if (dy > swipeConfiguration.horizontalSwipeMaxHeightThreshold) return;
        if (positiveVelocity < swipeConfiguration.horizontalSwipeMinVelocity)
          return;
        if (velocity < 0) {
          //Swipe Up
          if (onSwipeLeft != null) {
            onSwipeLeft();
          }
        } else {
          //Swipe Down
          if (onSwipeRight != null) {
            onSwipeRight();
          }
        }
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Mulish',
      ),
      home: const MyHomePage(title: 'Gerador de cores aleatórias'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int coordenadasX = 0;
  int coordenadasY = 0;
  Color? corCirculo = Colors.amber;

  void CorRand() {
    setState(() {
      corCirculo = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    });
  }
  void subir() {
    setState(() {
      coordenadasX++;
    });
  }
  void descer() {
    setState(() {
      coordenadasX--;
    });
  }
  void direita() {
    setState(() {
      coordenadasY++;
    });
  }
  void esquerda() {
    setState(() {
      coordenadasY--;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Center(
          child: SwipeDetector(
              child:Stack(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Text("$coordenadasX $coordenadasY")
                      ),
                     width: 600.0,
                     height: 600.0,
                     decoration: BoxDecoration(
                        color: corCirculo,
                        shape: BoxShape.circle,
            ),
          ),
              ]
              ),
              onSwipeUp: () {
                subir();
                CorRand();
              },
              onSwipeDown: () { 
                descer();
                CorRand();
              }, 
              onSwipeRight: () {
                direita();
                CorRand();
              }, 
              onSwipeLeft: () {
                esquerda();
                CorRand();
              },
            ),
          ),
      );
  }
}
