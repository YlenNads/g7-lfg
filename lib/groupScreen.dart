import 'package:flutter/material.dart';
import 'chat.dart';
import 'dart:async';
import 'package:map_view/map_view.dart';
import 'roundedButton.dart';
import 'locationMap.dart';
import 'gruppen.dart';
import 'home.dart';

class GroupScreen extends StatefulWidget{
  final Gruppen gruppe;
  final List<Gruppen> gruppen;
  GroupScreen({Key key, @required this.gruppe, @required this.gruppen}): super(key:key);
  @override
  _GroupScreen createState() => new _GroupScreen(gruppe: gruppe, gruppen: gruppen);

}

class _GroupScreen extends State<GroupScreen>{
  final Gruppen gruppe;
  final List<Gruppen> gruppen;
  _GroupScreen({Key key, @required this.gruppe, @required this.gruppen});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new DefaultTabController(
        length: 4,
        child: new Scaffold(
          appBar: new AppBar(
            leading: ListTile(
              leading: Icon(Icons.arrow_back, color: Colors.white,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=> Home()));
              },
            ),
            backgroundColor: Colors.red[800],
            title: new Text( gruppe.name),
            bottom: new TabBar(
              indicatorColor: Colors.white,
              tabs: [
                new Tab(icon: new Icon(Icons.location_on)),
                new Tab(icon: new Icon(Icons.chat)),
              ],
            ),
          ),
          body: new Center(
            child: new Container(
              padding: new EdgeInsets.all(10.0),
              child: new TabBarView(
                  children: [
                    new LocationMap(),
                    new ChatScreen(),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}