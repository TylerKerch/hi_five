import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hi_five/screens/profile_screen.dart';
import 'package:hi_five/screens/group_screen.dart';
import 'package:hi_five/screens/feed_screen.dart';
import 'package:hi_five/screens/signup_screen.dart';
import 'package:hi_five/screens/take_picture_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' as qr;

import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';
import 'globals.dart' as globals;
import 'login_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key, required this.camera}) : super(key: key);
  final CameraDescription camera;

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  late List<Widget> _pages;
  int _index = 1;

  @override
  void initState() {
    super.initState();
    _pages = [
      const GroupScreen(),
      FeedScreen(camera: widget.camera),
      const ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if (!authProvider.loggedIn) {
      return const LoginScreen();
    }
    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _index = index;
            });
          },
        ),
        bottomNavigationBar: ClipRect(
            child: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black54,
          backgroundColor: Colors.white.withOpacity(0.9),
          showSelectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.workspaces_outlined),
              label: 'Group',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections_outlined),
              label: 'Feed',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Profile'),
          ],
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
              if(index!=1){
                if(globals.qrController != null){
                  globals.qrController!.pauseCamera();
                }
              }
              _pageController.animateToPage(_index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn);
            });
          },
        )));
  }
}
