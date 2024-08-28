import 'package:flutter/material.dart';

class AnimacaoImplicita extends StatefulWidget {
  @override
  _AnimacaoImplicitaState createState() => _AnimacaoImplicitaState();
}

class _AnimacaoImplicitaState extends State<AnimacaoImplicita> {
  bool _status = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          padding: EdgeInsets.all(20),
          width: _status ? 200 : 300,
          height: _status ? 300 : 200,
          color: _status ? Colors.white : Colors.purpleAccent,
          duration: const Duration( seconds: 2 ),
          curve: Curves.elasticInOut,
          child: Image.asset("images/logo.png"),
        ),
        TextButton(
            onPressed: () {
              setState(() {
                _status = !_status;
              });
            },
            child: Text("Alterar"))
      ],
    );
  }
}
