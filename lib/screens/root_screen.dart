import 'package:flutter/material.dart';
import 'package:hi_five/screens/profile_screen.dart';
import 'package:hi_five/screens/group_screen.dart';
import 'package:hi_five/screens/feed_screen.dart';
import 'package:hi_five/screens/login_screen.dart';

import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

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
    const FeedScreen(),
    const ProfileScreen()];
    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    //   setState(() {
    //     _currentUser = account;
    //   });
    //   if (_currentUser != null) {
    //     _handleGetContact(_currentUser!);
    //   }
    // });
    // _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {

    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if(!authProvider.loggedIn){
        //return LoginScreen();
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
                    BottomNavigationBarItem(
                        icon: Icon(Icons.face),
                        label: 'Profile'),
                  ],
                  currentIndex: _index,
                  onTap: (index) {
                    setState(() {
                      _index = index;
                      _pageController.animateToPage(_index,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);

                    });
                  },
                )));
  }
}