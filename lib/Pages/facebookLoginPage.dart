import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/material.dart';
import 'package:sample_list/helpers.dart';

class FacebookLoginPage extends StatefulWidget {
  @override
  _FacebookLoginPageState createState() => new _FacebookLoginPageState();
}

class _FacebookLoginPageState extends State<FacebookLoginPage> {
  var profile;
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  String _message = 'Log in to facebook by pressing the button below.';

  Future<Null> _login() async {
    final FacebookLoginResult result =
        await facebookSignIn.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        try {
          var graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}');
          var _profilefb = json.decode(graphResponse.body);

          setState(() {
            profile = _profilefb;
          });
        } catch (e) {}

        break;
      case FacebookLoginStatus.cancelledByUser:
        Helpers().getToast('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
       Helpers().getToast('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

 //handle logout 
  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    setState(() {      
        });
   Helpers().getToast('Logged out');
   
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: _buildBody(),
    ));
  }

  //Build the display components of the Page
  Widget _buildBody() {
    if (profile != null) {
      setState(() {
       Helpers().getToast('Signed in successfully');
      });
      return new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new ListTile(
            contentPadding: EdgeInsets.only(top: 20.0),
          ),
          new ListTile(
            contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            leading: const Icon(Icons.person_pin_circle),
            title: new TextField(
              controller: TextEditingController(text: profile["first_name"]),
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                hintText: "First Name",
              ),
            ),
          ),
          new ListTile(
            contentPadding: EdgeInsets.only(
                bottom: 20.0, left: 20.0, right: 20.0, top: 20.0),
            leading: const Icon(Icons.people),
            title: new TextField(
              controller: TextEditingController(text: profile["last_name"]),
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                hintText: "Last Name",
              ),
            ),
          ),
          new ListTile(
            contentPadding:
                EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
            leading: const Icon(Icons.email),
            title: new TextField(
              controller: TextEditingController(text: profile["email"]),
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                hintText: "Email",
              ),
            ),
          ),
          new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new FloatingActionButton.extended(
                  label: const Text('SIGN OUT'),
                  onPressed: () => _logOut(),
                  backgroundColor: Colors.blue,
                  icon: new Icon(Icons.play_arrow),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(85.0, 15.0))),
                ),
              ]),
          new ListTile(
            contentPadding:
                EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
          )
        ],
      );
    } else {
      return new Scaffold(
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(_message),
              new ListTile(
                contentPadding: EdgeInsets.all(20.0),
              ),
              new FloatingActionButton.extended(
                onPressed: _login,
                label: new Text('Log in'),
                backgroundColor: Colors.blue,
                icon: new Icon(Icons.play_arrow),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(85.0, 15.0))),
              ),
            ],
          ),
        ),
      );
    }
  }
}
