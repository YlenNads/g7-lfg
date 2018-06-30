import 'package:flutter/material.dart';
import 'einladungen.dart';
import 'gruppen.dart';
import 'roundedButton.dart';
import 'inputTextField.dart';


class GroupMaking extends StatefulWidget{
  final List<Gruppen> gruppen;
  GroupMaking({Key key, @required this.gruppen}):super(key:key);
  @override
  _GroupMaking createState() => new _GroupMaking(gruppen: gruppen);
}

class _GroupMaking extends State<GroupMaking>
{

  bool begAnzahl;

  final List<Gruppen> gruppen;
  final pwKey = GlobalKey(debugLabel: 'ow');
  final formKey = GlobalKey<FormState>(debugLabel: 'inputText');
  String gruppenName = '2';
  var anzahl;
  String password;
  _GroupMaking({Key key, @required this.gruppen});


  var pw = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    /*Card pwCard = new Card( child: TextFormField(
      // keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white,fontSize: 20.0),
      decoration: InputDecoration(
          labelText: 'Passwort',
          errorStyle: TextStyle(color: Colors.black, fontSize: 16.0),
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          enabled: false,
          fillColor: Colors.black38,
          prefixIcon: Icon(Icons.lock, color: Colors.white,)
      ),
      // validator: (val) => val.contains('@') ? 'nicht erlaubt': null,
      validator: (val){
        if(val.contains(',') || val.contains('.') || val.contains(' ')){
          return 'Nicht erlaubt!';
        }else{
          return null;
        }
      },
      onSaved: (val) => anzahl = val,
    ),);
    */
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
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Divider(height: 10.0,color: Colors.transparent,),
                      Card(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white,fontSize: 20.0),
                          decoration: InputDecoration(
                            //icon: Icon(Icons.border_color, color: Colors.black,),
                            labelText: 'Gruppen Name',
                            errorStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                            labelStyle: TextStyle(color: Colors.white),
                            //hintStyle: TextStyle(color: Colors.black),
                           // hintText: 'Gruppen Name',
                            filled: true,
                            fillColor: Colors.red.shade600,
                            prefixIcon: Icon(Icons.border_color, color: Colors.white,),
                            // labelStyle: TextStyle(color: Colors.black,fontSize: 20.0)
                          ),
                          validator: (val) => val.length <1 ? 'Zu kurz' :null,
                          onSaved: (val) => gruppenName = val,
                        ),
                      ),

                      Divider(height: 20.0, color: Colors.transparent,),
                      Card(
                        child: TextFormField(
                         // keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white,fontSize: 20.0),
                          decoration: InputDecoration(
                              labelText: 'Anzahl Mitglieder',
                              errorStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                              labelStyle: TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Colors.red.shade600,
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
                          Text('Begrenzte Mitglieder:',style: TextStyle(color: Colors.black), ),
                          Switch(
                            activeColor: Colors.black,
                            activeTrackColor: Colors.red,
                            inactiveTrackColor: Colors.black45,
                            value: bool.fromEnvironment('Anzahl', defaultValue: false),
                            onChanged: (value){
                              begAnzahl = true;
                            },
                          ),
                        ],
                      ),
                      Divider(height: 50.0, color: Colors.transparent,),
                      Column(
                        children: <Widget>[
                          Card(
                            child: TextFormField(
                              // keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white,fontSize: 20.0),
                              decoration: InputDecoration(
                                  labelText: 'Passwort',
                                  enabled: pw,
                                  errorStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                                  labelStyle: TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Colors.red.shade600,
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
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('Passwort:',style: TextStyle(color: Colors.black), ),
                          Switch(
                            activeColor: Colors.black,
                            activeTrackColor: Colors.red,
                            inactiveTrackColor: Colors.black45,
                            value: bool.fromEnvironment('Pw', defaultValue: false),
                            onChanged: (value){
                              pw = value;
                            },
                          ),
                        ],
                      ),
                      Divider(color: Colors.transparent,height: 20.0,),
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
                          gruppen.add(new Gruppen(gruppenName, anzahl));
                          if(formKey.currentState.validate()){
                            Navigator.push(context, new MaterialPageRoute(builder: (context) => new Einladung(gruppen: gruppen,)));
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
  void _submit(){
    final form = formKey.currentState;
    if(form.validate()) {
      form.save();
    }
  }
}