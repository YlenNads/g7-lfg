import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'einladungen.dart';
import 'gruppen.dart';

class GroupMaking extends StatefulWidget{
  final String user_name;
  GroupMaking({Key key, @required this.user_name}):super(key:key);
  @override
  _GroupMaking createState() => new _GroupMaking(user_name: user_name);
}


String anzahl = 'Unbegrenzte Mitgliederanzahl';
class _GroupMaking extends State<GroupMaking>
{

  final pwKey = GlobalKey(debugLabel: 'ow');
  final formKey = GlobalKey<FormState>(debugLabel: 'inputText');
  String gruppenName;
  String password;
  final String user_name;
  _GroupMaking({Key key, @required this.user_name});

  var pw = false;

  //neuer versuch der aber auch nicht klappt .... 
  Future<Map> postData(Map data) async {
    Response res = await post("http://192.168.0.101:3000/api/groups/", body: json.encode(data), headers: {
      "Content-Type": "application/json; charset=UTF-8",
      // "Accept": "application/json"
    }); // post api call
    Map data_neu = json.decode(res.body);
    return data_neu;
  }

  //hat vorher funktioniert ...
  void _AddNewGroup(String creator, String gname ){
   /* post("http://192.168.0.101:3000/api/groups/",headers:{
      "Content-Type": "application/json; charset=UTF-8",
      // "Accept": "application/json"
    }, body: ({"name": gname, "creator":  creator}));
*/
  
 
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: true,
          title: new Text('Neue Gruppe Erstellen'),
          backgroundColor: Colors.red[800],
        ),
        body: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      Divider(height: 10.0,color: Colors.transparent,),

                      Card(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white,fontSize: 20.0),
                          decoration: InputDecoration(
                            labelText: 'Gruppen Name',
                            errorStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.red.shade600,
                            prefixIcon: Icon(Icons.border_color, color: Colors.white,),
                          ),
                          validator: (val) => val.length <1 ? 'Zu kurz' :null,
                          onSaved: (val) => gruppenName = val,
                        ),
                      ),

                      Divider(height: 30.0, color: Colors.transparent,),

                      MemberField(),

                      Divider(height: 30.0, color: Colors.transparent,),

                      PasswordField(),

                      Divider(color: Colors.transparent,height: 60.0,),

                      RaisedButton(
                        color: Colors.red[800],
                        splashColor: Colors.black,
                        shape: RoundedRectangleBorder(side: BorderSide.none, borderRadius:  BorderRadius.circular(10.0)),
                        padding: const EdgeInsets.all(5.0),
                        child: new ListTile(
                          leading: new Icon(Icons.email, color: Colors.white,),
                          title: new Text('Einladung verschicken',
                            style: new TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: (){
                          _submit();
                          if(formKey.currentState.validate()){
                            // _AddNewGroup(user_name, gruppenName);
                            postData({"name": gruppenName, "creator":  user_name});
                            Navigator.push(context, new MaterialPageRoute(builder: (context) => new Einladung(user_name: user_name)));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ]
        )
    );
  }
  @override
  void initState(){
    super.initState();
  }
  
  void _submit(){
    final form = formKey.currentState;
    if(form.validate()) {
      form.save();
    }
  }
}

class PasswordField extends StatefulWidget{
  PasswordField({Key key}) : super (key: key);
  @override
  _PasswordField createState() => _PasswordField();
}

class _PasswordField extends State<PasswordField>{
  bool _pwAktive = false;

  void _handleTap(value){
    setState(() {
      if(_pwAktive){
        _pwAktive = false;
      }else{
        _pwAktive = true;
      }
    });
  }

  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Card(
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white,fontSize: 20.0),
            decoration: InputDecoration(
                labelText: 'Passwort',
                enabled: _pwAktive,
                errorStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: _pwAktive ? Colors.red.shade600 : Colors.black38,
                prefixIcon: Icon(Icons.lock, color: Colors.white,)
            ),
            validator: (val){
              if(val.contains(',') || val.contains('.') || val.contains(' ')){
                return 'Nicht erlaubt!';
              }else{
                return null;
              }
            },
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('Passwort:',style: TextStyle(color: Colors.black), ),
            Checkbox(
              activeColor: Colors.red,
              value: _pwAktive ? true : false,
              onChanged: _handleTap,
            ),
          ],
        ),
      ],
    );
  }

}

class MemberField extends StatefulWidget{
  MemberField({Key key}) : super (key: key);
  @override
  _MemberField createState() => _MemberField();
}

class _MemberField extends State<MemberField>{
  bool _mAktive = false;

  void _handleTap(value){
    setState(() {
      if(_mAktive){
        _mAktive = false;
      }else{
        _mAktive = true;
      }
    });
  }

  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Card(
          child: TextFormField(
            // keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white,fontSize: 20.0),
            decoration: InputDecoration(
                labelText: 'Begrenzte Mitglieder:',
                enabled: _mAktive,
                errorStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: _mAktive ? Colors.red.shade600 : Colors.black38,
                prefixIcon: Icon(Icons.border_color, color: Colors.white,)
            ),
            validator: (val){
              if(val.contains(',') || val.contains('.') || val.contains(' ')){
                return 'Nicht erlaubt!';
              }else{
                return null;
              }
            },
            onSaved: (val) => anzahl = val,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('Begrentze Mitgliederzahl:',style: TextStyle(color: Colors.black), ),
            Switch(
              activeColor: Colors.red[900],
              activeTrackColor: Colors.red[300],
              value: _mAktive ? true : false,
              onChanged: _handleTap,
            ),
          ],
        ),
      ],
    );
  }

}
