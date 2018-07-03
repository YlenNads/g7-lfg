import 'package:flutter/material.dart';
import 'groupeMaking.dart';
import 'einladungen.dart';
import 'chat.dart';
import 'package:map_view/map_view.dart';
import 'roundedButton.dart';
import 'locationMap.dart';
import 'gruppen.dart';
import 'groupScreen.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget{
  final String user_name;
  Home({Key key, @required this.user_name}):super(key:key);
  @override
  //_HomeBar createState() => new _HomeBar(gruppen: gruppen);
  // Für DB:
    _HomeBar createState() => new _HomeBar(user_name: user_name);

}

enum NavItems{
  Einstellungen,
  Logout
}

class _HomeBar extends State<Home>{
  final String user_name;
  _HomeBar({Key key, @required this.user_name});
  List user;
  List gruppen;
  List user_gruppen;
  var responseb;
  Future<String> getGroup() async{
    var response = await http.get(Uri.encodeFull("http://192.168.0.101:3000/api/groups" ),
        headers: {
          "Accept": "application/json"
        }
    );
    setState((){
      var resBody = json.decode(response.body);
      responseb = jsonDecode(response.body);
      gruppen = resBody;

    });
  }



  Future<String> getUsersGroups() async{
    var response = await http.get(Uri.encodeFull("http://192.168.0.101:3000/api/" + user_name + "/groups" ),
        headers: {
          "Accept": "application/json"
        }
    );
    setState((){
      var resBody = json.decode(response.body);
      responseb = jsonDecode(response.body);
      user_gruppen = resBody;
    });
  }

  final list = ListTile.divideTiles(tiles: null);
  void _navItems (NavItems selected){
    switch(selected){
      case NavItems.Einstellungen:
        break;
      case NavItems.Logout:
        break;


    }
  }
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new DefaultTabController(
          length: 4,
          child: new Scaffold(
            floatingActionButton: new FloatingActionButton(
              child: new Icon(Icons.add),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new GroupMaking(user_name: user_name,)));
              },
            ),
            appBar: new AppBar(
              backgroundColor: Colors.red[800],
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text ("Home", style: TextStyle(color: Colors.white),),
                  new Text (user_name, style: TextStyle(color: Colors.white),),
                ],
              ),
              actions: <Widget>[
               new PopupMenuButton<NavItems>(
                 onSelected: _navItems,
                 itemBuilder: (BuildContext context){
                   return [
                     new PopupMenuItem(
                       value: NavItems.Einstellungen,
                       child: new Text('Einstellungen'),
                     ),
                     new PopupMenuItem(
                       value: NavItems.Logout,
                       child: new Text('Logout'),
                     ),
                   ];
                 },
               ),
              ],
            ),
            body: new Center(
              child: new Container(
                padding: new EdgeInsets.all(10.0),
                  child: ListView.builder(
                      // für die DB
                      itemCount: user_gruppen == null ? 0 : user_gruppen.length,
                       // itemCount: gruppen.length,
                        addAutomaticKeepAlives: true,
                        itemBuilder: (context, index) {
                          return new Container(
                            child: Card(
                                color: Colors.red[800],
                                child: ListTile(
                                  leading: const Icon(Icons.group, color: Colors.white,),
                                  //title: Text(gruppen[index]["name"], style: new TextStyle(color: Colors.white),),
                                  //subtitle: Text("Anzahl: " + gruppen[index]["email"]),
                                  title: Text(user_gruppen[index]["name"], style: TextStyle(color: Colors.white),),
                                  //title: Text(gruppen[index].name, style: new TextStyle(color: Colors.white),),
                                  //subtitle: Text(gruppen[index].maximalzahl,style: new TextStyle(color: Colors.white)),
                                  /*onTap: () {
                                   // Navigator.push(context, new MaterialPageRoute(builder: (context) => GroupScreen(gruppe: gruppen[index],gruppen: gruppen,)),);
                                    },*/
                                )
                            ),
                          );
                        }),
              ),
            ),
          ),
      ),
    );
  }
  @override
  void initState(){
    super.initState();
    this.getGroup();
    this.getUsersGroups();
  }
}



