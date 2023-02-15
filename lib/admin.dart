import 'package:class_app/addpage.dart';
import 'package:class_app/listpage.dart';
import 'package:class_app/studentaddpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.person, color: Colors.blue),
      label: "Tutor",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book, color: Colors.blue),
      label: "Student",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: [AddPage(), StudentAddPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _bottomNavigationBarItems,
        onTap: (index) {
          setState(() {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          });
        },
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
