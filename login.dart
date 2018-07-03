import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'inputTextField.dart';
import 'roundedButton.dart';
import 'home.dart';
import 'registerPage.dart';
import 'gruppen.dart';
import 'package:http/http.dart' as http;



//final googleSignIn = new GoogleSignIn();
String loggedinUser;
var loggedInUsername;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

TextStyle textStyle = new TextStyle(
    color: const Color.fromRGBO(255, 255, 255, 0.4),
    fontSize: 16.0,
    fontWeight: FontWeight.normal);



Color textFieldColor = const Color.fromRGBO(50, 50, 50, 0.5);
ScrollController scrollController = new ScrollController();


class Login extends StatefulWidget {

  @override
  LoginForm createState() => new LoginForm();
}



class LoginForm extends State<Login> with SingleTickerProviderStateMixin{

  String user_name;
  String user_email;
  String user_pw;
  String user_email1 = "meName";
  String user_pw1 = "wertzu";
  Map usermap;

  final IconData mail = const IconData(0xe158, fontFamily: 'MaterialIcons');
  final IconData lock_outline = const IconData(0xe899, fontFamily: 'MaterialIcons');
  final IconData signinicon=const IconData(0xe315, fontFamily: 'MaterialIcons');
  final IconData signupicon=const IconData(0xe316, fontFamily: 'MaterialIcons');
  bool _autovalidate = false;
  bool _formWasEdited = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = new GlobalKey<FormFieldState<String>>();
  Animation<Color> animation;
  AnimationController controller;

  final String group_url = "http://swapi.co/api/films";
  final String user_url = "http://192.168.0.101:3000/api/users";
  List user;
  List gruppen;



  Future<String> getDataUser() async{
    var response = await http.get(Uri.encodeFull(user_url),
        headers: {
          "Accept": "application/json"
        }
    );

    setState(() {
      var resBody = json.decode(response.body);
      user = resBody;
    });

  }



  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }


/*   _ensureLoggedIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
      user ??= await googleSignIn.signInSilently();
    if (user == null) {
      await googleSignIn.signIn();
    }
  } */
/*
  _handleSubmitted1() async {
    setState(() {
      /* _isgooglesigincomplete = false; */

    });
    */
/*     await _ensureLoggedIn();
    GoogleSignInAccount user = googleSignIn.currentUser;
    UserData guser=new UserData();
    guser.EmailId=user.email;
    guser.name=user.displayName;
    guser.locationShare=false;
    final String guserjson=jsonCodec.encode(guser);
    final Map usrmap=await getUsers();
    usrmap.forEach((k,v){
      if(v.EmailId==user.email){
        userexists=true;
        loggedinUser=user.email;
        loggedInUsername=user.displayName;
        Navigator.of(context).pushReplacementNamed('/b');
      }
    });
    if(userexists==false){
      await httpClient.post('https://fir-trovami.firebaseio.com/users.json',body: guserjson);
      loggedinUser=user.email;
      loggedInUsername=user.displayName;
      await Navigator.of(context).pushReplacementNamed('/b');
    } */
  //}

  void _submit(){
    final form = _formKey.currentState;
    if(form.validate()) {
      form.save();
    }
  }

  _handleSubmitted() async {


    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      _autovalidate = true;
      showInSnackBar('Bitte die nötigen Angaben machen.');
    } else {
      form.save();
    }
      showInSnackBar(
          'Email oder Password sind inkorrekt. Bitte erneut versuchen.'
      );

  }

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Pflichtfeld.';
    final  nameExp = new RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');
    if (!nameExp.hasMatch(value))
      return 'Bitte korrekte Email angeben.';
    return null;
  }

  String _validatePassword(String value) {
    _formWasEdited = true;
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty)
      return 'Pflichtfeld.';
    if (passwordField.value != value)
      return 'Passwort nicht korrekt.';
    return null;
  }


  String _setName(){
    int length = user == null ? 0 : user.length;
    for (int i = 0; i< length;i++){

      if (user[i]["email"] == user_email){
        user_name = user[i]["name"];
        return user_name;
      }
    }
    return "User";
  }

  @override
  void initState() {
    this.getDataUser();
    controller = new AnimationController(
        duration: const Duration(seconds: 10), vsync: this);
    animation = new ColorTween(begin: Colors.red, end: Colors.red).animate(controller)
      ..addListener(() {
        setState(() {
        });
      });
//    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      key: _scaffoldKey,
      body: new SingleChildScrollView(
        controller: scrollController,
        child:new Container(
         // decoration: new BoxDecoration(
/*         image: new DecorationImage(
        image: new AssetImage('assets/images/G7-Weltkugel.png'),
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
        ), */
          //),
          child:new Column(
            children: <Widget>[
              new Container(
                height: screenSize.height /6,
                width: screenSize.width,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child:
                      new Text(
                        'Looking for Group',
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 40.0),
                      ),
                    ),

                  ],
                ),
              ),
              new Container(
                height: 100.0,
//                width: screenSize.width/6,
                child: new Image.asset("assets/images/G7-Weltkugel.png", fit: BoxFit.scaleDown,scale:  40.0,  ),
                padding: const EdgeInsets.only(bottom: 0.0),
              ),

              new Container(
                height: 5*screenSize.height /6,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    new Form(
                      key: _formKey,
                      autovalidate: _autovalidate,
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            child: new InputField(
                                hintText: 'Email',
                                obscureText: false,
                                textInputType: TextInputType.emailAddress,
                                textStyle: textStyle,
                                hintStyle: textStyle,
                                textFieldColor: textFieldColor,
                                icon: Icons.mail_outline,
                                iconColor: const Color.fromRGBO(255, 255, 255, 0.4),
                                bottomMargin: 20.0,
                                width: screenSize.width-50,
                             //   validateFunction: _validateName,
                                onSaved: (String email) {
                                  user_email = email;
                                  //                   logindet.EmailId = email;
                                }
                            ),
                          ),
                          new InputField(
                              hintText: 'Passwort',
                              obscureText: true,
                              textInputType: TextInputType.text,
                              textStyle: textStyle,
                              hintStyle: textStyle,
                              textFieldColor: textFieldColor,
                              icon: Icons.lock_outline,
                              iconColor: Colors.white,
                              bottomMargin: 20.0,
                              width: screenSize.width-50,
                              onSaved: (String pass) {
                                user_pw = pass;
                                //                    logindet.password = pass;
                              }
                          ),
                        ],
                      ),
                    ),
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new RoundedButton(
                          buttonName: 'Einloggen',
                         // onTap: _handleSubmitted,
                          onTap: () {
                            _submit();
                            usermap = {"email": user_email, "pw" : user_pw};
                            var url = "http://192.168.0.101:3000/api/authentication";
                            http.post(url, body: json.encode(usermap),headers:{
                              "Content-Type": "application/json; charset=UTF-8",
                              // "Accept": "application/json"
                            }, )
                                .then((response) {
                              print("Response status: ${response.statusCode}");
                              print("Response body: ${response.body}");
                              var resip = jsonDecode(response.body);

                              if (resip["success"]) {
                                _setName();
                                Navigator.push(context, new MaterialPageRoute(
                                    builder: (context) => new Home(user_name: user_name,)));
                              }
                              });


                          },
                          width: screenSize.width-50,
                          height: 50.0,
                          bottomMargin: 10.0,
                          borderWidth: 2.0,
                         // buttonColor: const Color.fromRGBO(162, 32, 32, 0.8),
                          buttonColor: Colors.red[800],
                        ),
                        new RoundedButton(
                          buttonName: 'Registrieren',
                          onTap: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(builder: (context) => new RegisterPage()),
                            );
                           Navigator.of(context).pushNamed('/a');
                          },
                          highlightColor:const Color.fromRGBO(255, 255, 255, 0.1),
                          width: screenSize.width-50,
                          height: 50.0,
                          bottomMargin: 10.0,
                          borderWidth: 2.0,
                         // buttonColor: const Color.fromRGBO(162, 32, 32, 0.8),
                          buttonColor: Colors.red[800],
                        ),
                        new RoundedButton(
                          buttonName: 'Weiter ohne login',
                          onTap: () {

                           Navigator.push(context, new MaterialPageRoute(builder: (context) => new Home()));
                            Navigator.of(context).pushNamed('/a');
                          },
                          highlightColor:const Color.fromRGBO(255, 255, 255, 0.1),
                          width: screenSize.width-50,
                          height: 50.0,
                          bottomMargin: 10.0,
                          borderWidth: 2.0,
                          buttonColor: const Color.fromRGBO(162, 32, 32, 0.5),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



}