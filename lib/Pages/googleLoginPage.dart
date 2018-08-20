import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import 'package:sample_list/helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class GoogleLoginPage extends StatefulWidget {
  @override
  GoogleLoginPageState createState() => new GoogleLoginPageState();
}

class GoogleLoginPageState extends State<GoogleLoginPage> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<Null> _handleGetContact() async {
    setState(() {});
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {});
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    setState(() {});
  }

  Future<Null> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      _currentUser = null;
      await _handleSignOut();
      print(error);
    }
  }

  Future<Null> _handleSignOut() async {
    _googleSignIn.disconnect();
    Helpers().getToast('Logged Out');
  }

  //Build the display components of the Page
  Widget _buildBody() {
    if (_currentUser != null) {
      var tt =
          'https://cdn6.aptoide.com/imgs/a/b/2/ab28e02d0ed402452c5308e637686658_icon.png?w=240';
      setState(() {
       Helpers().getToast('Signed in successfully');
        if (_currentUser.photoUrl != null) {
          tt = _currentUser.photoUrl;
        }
      });
      return new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(),
          ),
          new CircleAvatar(
            radius: 75.0,
            backgroundImage: new NetworkImage(tt),
            backgroundColor: Colors.white,
          ),
          new ListTile(
            contentPadding: EdgeInsets.only(
                bottom: 20.0, left: 20.0, right: 20.0, top: 20.0),
            leading: const Icon(Icons.person),
            title: new TextField(
              controller: TextEditingController(text: _currentUser.displayName),
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                hintText: "Name",
              ),
            ),
          ),
          new ListTile(
            contentPadding:
                EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
            leading: const Icon(Icons.email),
            title: new TextField(
              controller: TextEditingController(text: _currentUser.email),
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
                  onPressed: _handleSignOut,
                  backgroundColor: Colors.blue,
                  icon: new Icon(Icons.play_arrow),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(85.0, 15.0))),
                ),
                new FloatingActionButton.extended(
                  label: const Text('REFRESH'),
                  onPressed: _handleGetContact,
                  backgroundColor: Colors.blue,
                  icon: new Icon(Icons.play_arrow),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(85.0, 15.0))),
                ),
              ]),
          new Expanded(
            flex: 1,
            child: new Container(),
          )
        ],
      );
    } else {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("You are not currently signed in to google."),
          new FloatingActionButton.extended(
            label: const Text('SIGN IN'),
            onPressed: _handleSignIn,
            backgroundColor: Colors.blue,
            icon: new Icon(Icons.play_arrow),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(85.0, 15.0))),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: _buildBody(),
    ));
  }
}
