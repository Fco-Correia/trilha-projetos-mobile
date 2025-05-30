import 'package:flutter/material.dart';

class CriandoAnimacoesBasicas extends StatefulWidget {
  @override
  _CriandoAnimacoesBasicas createState() => _CriandoAnimacoesBasicas();
}

class _CriandoAnimacoesBasicas extends State<CriandoAnimacoesBasicas> {
  bool _status = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Meu app"),
      ),

      /*
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: Colors.green,
        padding: EdgeInsets.all(10),
        height: _status ? 10 :100,
      ),
      */
      /*
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: Colors.green,
        padding: EdgeInsets.only(bottom: 100,top:20),
        alignment: _status ? Alignment.bottomCenter : Alignment.topCenter,
        child: AnimatedOpacity(
          opacity: _status ? 1 : 0, 
          duration: Duration(seconds: 1),
          child: Container(
            height: 50,
            child: Icon(
              Icons.airplanemode_active,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
      */
      body: GestureDetector(
        onTap: () {
          setState(() {
            _status = !_status;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.linear,
          alignment: Alignment.center,
          width: _status? 60 : 160,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Stack(children: [
            Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                duration: Duration(
                  milliseconds: 100
                ),
                opacity: _status? 1 : 0,
                child: Icon(Icons.person_add,color: Colors.white,),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                duration: Duration(
                  milliseconds: 100
                ),
                opacity: _status? 0 : 1,
                child: Text(
                  "Mensagem",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
            )
          ],),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _status = !_status;
          });
        },
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 6,
        child: Icon(Icons.add_box),
      ),
    );
  }
}
