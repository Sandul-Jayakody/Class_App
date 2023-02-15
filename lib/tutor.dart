import 'package:class_app/addpage.dart';
import 'package:class_app/courseaddtutor.dart';
import 'package:class_app/courselisttutor.dart';
import 'package:class_app/listpage.dart';
import 'package:class_app/studentaddpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Tutor extends StatefulWidget {
  const Tutor({super.key});

  @override
  State<Tutor> createState() => _TutorState();
}

class _TutorState extends State<Tutor> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.list, color: Colors.blue),
      label: "Course List",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book, color: Colors.blue),
      label: "Add Courses",
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
        children: [CourseListPage_Tutors(), CourseAddPage()],
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
