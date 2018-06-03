import 'package:flutter/material.dart';
import 'home2.dart';

class Einladung extends StatefulWidget {
  @override
  _Einladung createState() => new _Einladung();
}

class _Einladung extends State<Einladung>{
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red[800],
        title: new Text('Einladung verschicken'),
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Divider(height: 70.0, color: Colors.transparent,),
                new Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, ),
                  child: new Text('Links: http://beispiel.link', textScaleFactor: 2.0, textAlign: TextAlign.start,),
                ),
                new Divider(height: 180.0, color: Colors.transparent,),
                new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Icon(Icons.share),
                    new Icon(Icons.android),
                    new Icon(Icons.attach_file)
                  ],
                ),
                new Divider(height: 70.0, color: Colors.transparent,),
               new Container(
                 padding: const EdgeInsets.all(20.0),
                 child:  new RaisedButton(
                   padding: const EdgeInsets.all(10.0),
                   onPressed: (){
                     Navigator.push(context,
                       new MaterialPageRoute(builder: (context) => new Home()),);
                   },
                   color: Colors.red[800],
                   child: new ListTile(
                     leading: new Icon(Icons.check, color: Colors.white,),
                     title: new Text('Fertig!', style: new TextStyle(
                         color: Colors.white
                     ),
                     ),
                   ),
                 ) ,
               ),


              ],
            ),
          )
        ],
      ),
    );
  }
}