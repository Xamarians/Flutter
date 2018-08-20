import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sample_list/helpers.dart';
import 'package:sample_list/Animations/loginPageAnimations.dart';

class LoginPage extends StatefulWidget {
  LoginPage({@required this.animation});
final AnimationController animation;
  @override
  _LoginPageState createState() => new _LoginPageState(loginButtonController: animation);
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
      _LoginPageState({
    @required  this.loginButtonController,
  }) : animation = new LoginEnterAnimation(loginButtonController);

  final LoginEnterAnimation animation;
  AnimationController loginButtonController;
  var usenameController = new TextEditingController();
  var passwordController = new TextEditingController();

  Future<Null> _playAnimation() async {
    if (usenameController.text == passwordController.text) {
      if ((usenameController.text.isEmpty) ||
          (passwordController.text.isEmpty)) {
        Helpers().getToast('Username or password cant be empty');
      } else {
        try {
          await loginButtonController.forward();
          await loginButtonController.reverse();
        } on TickerCanceled {}
      }
    } else {
      Helpers().getToast('Invalid Username or Password');
    }
  }

  @override
  void dispose() {
    super.dispose();
    loginButtonController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  bool btnLoginVisible = true;
  FocusNode _focus = new FocusNode();
  void _onFocusChange() {
    setState(() {
      btnLoginVisible = !btnLoginVisible;
    });
    debugPrint("Focus: " + _focus.hasFocus.toString());
  }

  Widget _constructLoginButton() {
    if (!btnLoginVisible) {
      return new Container();
    } else {
      return new Positioned(
          bottom: animation.animationbtnZoomout.value == 70
              ? 170.0
              : (MediaQuery.of(context).size.width / 2) -
                  animation.animationbtnZoomout.value / 3,
          left: animation.animationbtnZoomout.value == 70
              ? (MediaQuery.of(context).size.width -
                      animation.animationBtnSqueeze.value) /
                  2
              : (MediaQuery.of(context).size.width / 2) -
                  animation.animationbtnZoomout.value / 2,
          child: new Material(
            elevation: 20.0,
            color: Colors.transparent,
            child: new InkWell(
                onTap: () {
                  _playAnimation();
                },
                child: new Hero(
                  tag: "fade",
                  child: new Container(
                      width: animation.animationbtnZoomout.value == 70
                          ? animation.animationBtnSqueeze.value
                          : animation.animationbtnZoomout.value,
                      height: animation.animationbtnZoomout.value == 70
                          ? 60.0
                          : animation.animationbtnZoomout.value,
                      alignment: FractionalOffset.center,
                      decoration: new BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: animation.animationbtnZoomout.value < 400
                            ? new BorderRadius.all(const Radius.circular(30.0))
                            : new BorderRadius.all(const Radius.circular(0.0)),
                      ),
                      child: animation.animationBtnSqueeze.value > 75.0
                          ? new Text(
                              "Sign In",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.3,
                              ),
                            )
                          : animation.animationbtnZoomout.value < 300.0
                              ? new CircularProgressIndicator(
                                  value: null,
                                  strokeWidth: 1.0,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : null),
                )),
          ));
    }
  }

  Widget _constructBody() {
    return new Stack(
      fit: StackFit.passthrough,
      overflow: Overflow.clip,
      children: <Widget>[
        new Opacity(
          opacity: 0.7,
          child: new Image.asset(
            'assets/backdrop.png',
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: new Container(),
            ),
            new Expanded(
              flex: 5,
              child: new Image.asset(
                'assets/logo.png',
                color: Colors.white,
              ),
            ),
            new Expanded(
              flex: 1,
              child: new Container(),
            ),
            new Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                padding: EdgeInsets.only(bottom: 5.0),
                decoration: new BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    border: new Border.all(
                        width: 2.0,
                        style: BorderStyle.none,
                        color: Colors.white)),
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: new TextField(
                        controller: usenameController,
                        focusNode: _focus,
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          border: null,
                          hintText: 'Username',
                          hintStyle: new TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                       
                      ),
                    ),
                    new ListTile(
                      leading: const Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      title: new TextField(
                        controller: passwordController,
                        obscureText: true,
                        focusNode: _focus,
                        style: new TextStyle(
                          color: Colors.white
                        ),
                        decoration: new InputDecoration(
                          border: null,
                          hintText: 'Password',
                          hintStyle: new TextStyle(
                            color: Colors.white70,
                          ),
                        
                        ),
                      ),
                    ),
                  ],
                )),
            new Expanded(
              flex: 8,
              child: new Container(),
            ),
          ],
        ),
        _constructLoginButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: _constructBody(),
    );
  }
}
