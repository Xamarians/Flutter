import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sample_list/Animations/aboutPageAnimations.dart';
import 'package:sample_list/Animations/rotatingMenuAnimations.dart';
import 'package:sample_list/Animations/mediaPageAnimations.dart';
import 'package:sample_list/Models/navigationItem.dart';
import 'googleLoginPage.dart';
import 'chatPage.dart';
import 'formPage.dart';
import 'mapsPage.dart';
import 'facebookLoginPage.dart';
import 'dart:math';

class RotatingMenu extends StatefulWidget {
  RotatingMenu({@required this.animation, @required this.heroAnimation});
  final AnimationController animation;
  final AnimationController heroAnimation;

  @override
  _MyPageState createState() => new _MyPageState(
      animationControllerMenu: animation, heroController: heroAnimation);
}

enum _RoatingMenuAnimationStatus { closed, open, animating }

class _MyPageState extends State<RotatingMenu> with TickerProviderStateMixin {
  _MyPageState({
    @required this.animationControllerMenu,
    @required this.heroController,
  }) : animation =
            new RotatingMenuAnimations(animationControllerMenu, heroController);

  double appDrawerHeight = 80.0;
  double rotationAngle = 0.0;
  double screenWidth;
  double screenHeight;
  double heightFull = 00.0;
  List<Widget> _recentPages = [];
  List<NavigationItem> _navigationItems;
  TextEditingController headerTitle = new TextEditingController();
  Widget currentPage;

  final AnimationController animationControllerMenu;
  final AnimationController heroController;
  RotatingMenuAnimations animation;
  _RoatingMenuAnimationStatus menuAnimationStatus =
      _RoatingMenuAnimationStatus.closed;

//Handle weather to open the rotating drawer or to close it
  _handleMenuOpenClose() {
    if (menuAnimationStatus == _RoatingMenuAnimationStatus.closed) {
      heightFull = MediaQuery.of(context).size.height;
      animationControllerMenu.forward().orCancel;
    } else if (menuAnimationStatus == _RoatingMenuAnimationStatus.open) {
      animationControllerMenu.reverse().orCancel;
      Future.delayed(
        const Duration(milliseconds: 600),
        () => _changeHeight(),
      );
    }
  }

//change height of the drawer dynamically
  _changeHeight() {
    setState(() {
      heightFull = 00.0;
    });
  }

  @override
  void initState() {
    super.initState();

    _navigationItems = [
      new NavigationItem('About Us', Icons.photo_library),
      new NavigationItem('Forum', Icons.edit),
      new NavigationItem('Media', Icons.image),
      new NavigationItem('Maps', Icons.map),
      new NavigationItem('Google Login', Icons.group),
      new NavigationItem('Facebook Login', Icons.keyboard_arrow_right),
      new NavigationItem('Chat Screen', Icons.chat),
    ];

    if (currentPage == null || _recentPages.length == 0) {
      currentPage = new AboutDetailsAnimator();
      headerTitle = new TextEditingController();
      headerTitle.text = "About Us";
    }
    animationControllerMenu.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        menuAnimationStatus = _RoatingMenuAnimationStatus.open;
      } else if (status == AnimationStatus.dismissed) {
        menuAnimationStatus = _RoatingMenuAnimationStatus.closed;
      } else {
        menuAnimationStatus = _RoatingMenuAnimationStatus.animating;
      }
    });
    animation =
        new RotatingMenuAnimations(animationControllerMenu, heroController);
  }

  @override
  void dispose() {
    animationControllerMenu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Material(
        child: new Stack(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Container(
                  height: 80.0,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF333333),
                  padding: EdgeInsets.only(top: 40.0),
                  child: new Text(headerTitle.text,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.cyan,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      )),
                ),
                new Positioned(
                  right: 0.0,
                  top: 27.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.cyan,
                    ),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, "/LoginPage"),
                  ),
                ),
                new Positioned(
                    left: 0.0,
                    top: 27.0,
                    child: Transform.rotate(
                      angle: -pi / 2,
                      child: IconButton(
                        onPressed: _handleMenuOpenClose,
                        icon: Icon(
                          Icons.menu,
                          color: Colors.cyan,
                        ),
                      ),
                    )),
              ],
            ),
            _pageGenrate(),
            _rotatingDrawer(),
            new Hero(
                tag: "fade",
                child: new Center(
                  child: new Container(
                    height: animation.animationbtnZoomin.value,
                    width: animation.animationbtnZoomin.value,
                    decoration: new BoxDecoration(
                      borderRadius: animation.animationbtnZoomin.value < 400
                          ? new BorderRadius.all(const Radius.circular(30.0))
                          : new BorderRadius.all(const Radius.circular(0.0)),
                      color: Colors.cyan,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
    //return
  }

//Handle how back button will function
  Future<bool> onWillPop() async {
    if (_recentPages.length == 0) {
      return true;
    } else {
      setState(() {
        currentPage = _recentPages[_recentPages.length - 1];
        _recentPages.removeLast();
      });
      return false;
    }
  }

//Main page to display below the drawer as current page
  Widget _pageGenrate() {
    return new Container(
      margin: const EdgeInsets.only(top: 80.0),
      color: Colors.black,
      child: currentPage,
    );
  }

//construct the Rotating Drawer
  Widget _rotatingDrawer() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    return new Container(
      height: heightFull,
      width: screenWidth,
      child: new Transform.rotate(
          angle: animation.animationMenu.value,
          origin: new Offset(24.0, 56.0),
          alignment: Alignment.topLeft,
          child: new Transform.translate(
            offset: animation.animationMoveMenuItems.value,
            child: new Container(
              decoration: new BoxDecoration(
                color: Color(0xFF333333),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey[700],
                    spreadRadius: 0.0,
                    offset: new Offset(10.0, 0.0),
                    blurRadius: 20.0,
                  )
                ],
              ),
              width: screenWidth,
              height: screenHeight,
              child: new Stack(
                children: <Widget>[
                  _buildMenuTitle(),
                  _buildMenuIcon(),
                  _buildMenuContent(),
                ],
              ),
            ),
          )),
    );
  }

//Construct the Fading Title 
  Widget _buildMenuTitle() {
    return new Positioned(
      top: 32.0,
      left: 40.0,
      width: screenWidth,
      height: 24.0,
      child: new Transform.rotate(
          alignment: Alignment.topLeft,
          origin: Offset.zero,
          angle: pi / 2.0,
          child: new Center(
            child: new Container(
              child: new Opacity(
                opacity: animation.animationTitleFadeInOut.value,
                child: new Text(headerTitle.text,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.cyan,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    )),
              ),
            ),
          )),
    );
  }

//Build Hamburger(Drawer) Icon
  Widget _buildMenuIcon() {
    return new Transform.translate(
      offset: animation.animationMoveMenuIcon.value,
      child: new IconButton(
        icon: new Icon(
          Icons.menu,
          color: Colors.cyan,
        ),
        onPressed: _handleMenuOpenClose,
      ),
    );
  }

//Build the contents of Rotating Drawer
  Widget _buildMenuContent() {
    return new Padding(
      padding: const EdgeInsets.only(left: 60.0, top: 60.0),
      child: new ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          new DrawerHeader(
            child: new UserAccountsDrawerHeader(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/background.jpg'),
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                  ),
                  color: Colors.cyan,
                  border: Border.all(
                      color: Colors.cyan, style: BorderStyle.solid, width: 2.0),
                ),
                accountName: const Text(
                  'Successive',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: const Text(
                  'successive.tech@successive.tech',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: new CircleAvatar(
                    child: new Container(
                      decoration: new BoxDecoration(
                        borderRadius:
                            BorderRadius.all(new Radius.circular(50.0)),
                        border: new Border.all(
                          width: 2.0,
                          color: Colors.cyan,
                        ),
                      ),
                      child: new Container(
                        decoration: new BoxDecoration(
                          borderRadius:
                              BorderRadius.all(new Radius.circular(50.0)),
                          border: new Border.all(
                            width: 1.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    backgroundImage: new AssetImage('assets/flutter_logo.png')),
                otherAccountsPictures: <Widget>[]),
            padding: const EdgeInsets.all(0.0),
            margin: const EdgeInsets.all(0.0),
          ),
        ]..addAll(_buildNavigationItems()),
      ),
    );
  }

//Build the navigation titles with icons 
  List<Widget> _buildNavigationItems() {
    List<Widget> navList = [];
    for (int i = 0; i < _navigationItems.length; i++) {
      navList.add(new ListTile(
        title: new Text(
          _navigationItems[i].name,
          style: new TextStyle(color: Colors.white),
        ),
        trailing: new Icon(
          _navigationItems[i].icon,
          color: Colors.cyan,
        ),
        onTap: () {
          onNavigationIconClicked(i);
          for (int j = 0; j < navList.length; j++) {}
        },
      ));
    }
    return navList;
  }

//Handle which page to display as main Page
  onNavigationIconClicked(int i) {
    _handleMenuOpenClose();
    switch (_navigationItems[i].name) {
      case 'Forum':
        setState(() {
          headerTitle.text = 'Forum';
          _recentPages.add(currentPage);
          currentPage = new FormPage();
        });
        break;
      case 'Facebook Login':
        setState(() {
          headerTitle.text = 'Facebook Login';
          _recentPages.add(currentPage);
          currentPage = new FacebookLoginPage();
        });
        break;
      case 'Media':
        setState(() {
          headerTitle.text = 'Media';
          _recentPages.add(currentPage);
          currentPage = new MediaPageAnimator();
        });
        break;
      case 'Google Login':
        setState(() {
          headerTitle.text = 'Google Login';
          _recentPages.add(currentPage);
          currentPage = new GoogleLoginPage();
        });
        break;
      case 'Maps':
        setState(() {
          headerTitle.text = 'Maps';
          _recentPages.add(currentPage);
          currentPage = new MapPage();
        });
        break;
      case 'Chat Screen':
        setState(() {
          headerTitle.text = 'Chat Screen';
          _recentPages.add(currentPage);
          currentPage = new ChatPage();
        });
        break;
      case 'About Us':
        setState(() {
          headerTitle.text = 'About Us';
          _recentPages.add(currentPage);
          currentPage = new AboutDetailsAnimator();
        });
        break;
    }
  }
}
