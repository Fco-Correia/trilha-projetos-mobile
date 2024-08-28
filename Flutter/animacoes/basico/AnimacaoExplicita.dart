import 'package:flutter/material.dart';

class AnimacaoExplicita extends StatefulWidget {
  @override
  _AnimacaoExplicita createState() => _AnimacaoExplicita();
}

class _AnimacaoExplicita extends State<AnimacaoExplicita>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  AnimationStatus? _animationStatus;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this)
          ..repeat()..addStatusListener((status) {
            _animationStatus = status;
          });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: 300,
            height: 400,
            child: RotationTransition(
              child: Image.asset("images/logo.png"),
              alignment: Alignment.center,
              turns: _animationController,
            ),
          ),
          TextButton(
              onPressed: () {
                if (_animationStatus == AnimationStatus.dismissed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }

                /*
                if (_animationController.isAnimating) {
                  _animationController.stop();
                } else {
                  _animationController.repeat();
                }
                */
              },
              child: Text("Pressione"))
        ],
      ),
    );
  }
}
