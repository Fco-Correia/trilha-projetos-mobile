import 'package:flutter/material.dart';

class MaisSobreAnimacoes extends StatefulWidget {
  @override
  _MaisSobreAnimacoesState createState() => _MaisSobreAnimacoesState();
}

class _MaisSobreAnimacoesState extends State<MaisSobreAnimacoes>
      with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  Animation? _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    );

    _animation = Tween<Offset>(
        begin: Offset(0,0),
        end: Offset(60,0)
    ).animate( _animationController );

    /*
    _animation = Tween<double>(
      begin: 0,
      end: 1
    ).animate( _animationController );*/

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _animationController.forward();

    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: AnimatedBuilder(
        animation: _animation!,
        child: Stack(
          children: <Widget>[
            Positioned(
              width: 180,
              height: 180,
              left: 0,
              top: 0,
              child: Image.asset("imagens/logo.png"),
            )
          ],
        ),
        builder: (context, widget){

          return Transform.translate(
            offset: _animation!.value,
            child: widget,
          );

          /*
          return Transform.scale(
            scale: _animation.value,
            child: widget,
          );*/

          /*
          return Transform.rotate(
              angle: _animation.value,
              child: widget,
          );
          */

        },
      ),
    );
  }
}
