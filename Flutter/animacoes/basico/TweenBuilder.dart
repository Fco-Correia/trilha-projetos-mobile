import 'package:flutter/material.dart';

class TweenBuilder extends StatefulWidget {
  @override
  _TweenBuilder createState() => _TweenBuilder();
}

class _TweenBuilder extends State<TweenBuilder> {
  @override
  Widget build(BuildContext context) {
    return Center(
      /*
      child: TweenAnimationBuilder(
        duration: Duration(seconds: 2),
        tween: Tween<double>(begin: 0,end: 6.28),
        builder: (BuildContext context, double angulo, Widget? widget){
          return Transform.rotate(
            angle: angulo,
            child: Image.asset("images/logo.png"),
          );
        },
      ),
      */

      /*
      child: TweenAnimationBuilder(
        duration: Duration(seconds: 2),
        tween: Tween<double>(begin: 50,end: 180),
        builder: (BuildContext context, double largura, Widget? widget){
          return Container(
            color: Colors.green,
            width: largura,
            height: 60,
          );
        },
      ),
      */
      child: TweenAnimationBuilder(
        duration: Duration(seconds: 2),
        tween: ColorTween(begin: Colors.white,end: Colors.orange),
        child: Image.asset("images/estrelas.jpg"),
        builder: (BuildContext context, Color? cor, Widget? widget){
          return ColorFiltered(
            colorFilter: ColorFilter.mode(cor!, BlendMode.overlay),
            child: widget,
          );
        },
      ),

    );
  }
}
