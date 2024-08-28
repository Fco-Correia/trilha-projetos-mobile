import 'package:flutter/material.dart';

class BotaoCustomizado extends StatelessWidget {
  final String texto;
  final Color corTexto;
  final VoidCallback onPressed;

  BotaoCustomizado({
    required this.texto,
    this.corTexto = Colors.white,
    required this.onPressed
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:this.onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Color(0xff9c27b0)),
        padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.fromLTRB(32, 16, 32, 16)),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      child: Text(
        this.texto,
        style: TextStyle(color:this.corTexto, fontSize: 20),
      ),
    );
  }
  
}
