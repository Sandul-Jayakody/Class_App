import 'package:class_app/admin.dart';
import 'package:class_app/courselisttutor.dart';
import 'package:class_app/models/course.dart';
import 'package:class_app/services/firebase_crud_courses.dart';
import 'package:class_app/services/firebase_crud_students.dart';
import 'package:class_app/studentlistpage.dart';
import 'package:flutter/material.dart';

import '../models/employee.dart';
import '../services/firebase_crud.dart';
import 'listpage.dart';

class CourseEditPage extends StatefulWidget {
  final Course? course;
  CourseEditPage({this.course});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPage();
  }
}

class _EditPage extends State<CourseEditPage> {
  final name = TextEditingController();
  final code = TextEditingController();
  final Tutor = TextEditingController();
  final _docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _docid.value = TextEditingValue(text: widget.course!.uid.toString());
    name.value = TextEditingValue(text: widget.course!.name.toString());
    code.value = TextEditingValue(text: widget.course!.code.toString());
    Tutor.value = TextEditingValue(text: widget.course!.Tutor.toString());
  }

  @override
  Widget build(BuildContext context) {
    final DocIDField = TextField(
        controller: _docid,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final nameField = TextFormField(
        controller: name,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Course Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final positionField = TextFormField(
        controller: code,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Course Code",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final contactField = TextFormField(
        controller: Tutor,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Tutor",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => CourseListPage_Tutors(),
            ),
            (route) => false,
          );
        },
        child: const Text('View List of Courses'));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrudCourses.updateCourse(
                name: name.text,
                code: code.text,
                Tutor: Tutor.text,
                docId: _docid.text);
            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: Text(
          "Update",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Courses'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.navigate_before,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => CourseListPage_Tutors(),
                ),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DocIDField,
                  const SizedBox(height: 25.0),
                  nameField,
                  const SizedBox(height: 25.0),
                  positionField,
                  const SizedBox(height: 35.0),
                  contactField,
                  // viewListbutton,
                  const SizedBox(height: 45.0),
                  SaveButon,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
