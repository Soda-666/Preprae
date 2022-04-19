import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:soft_dev/model/storage.dart';
import 'package:soft_dev/screen/welcome.dart';

class AddprofileScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  Storage myStorage = Storage();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _addprofileCollection =
      FirebaseFirestore.instance.collection("addprofile");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Profile"),
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email", style: TextStyle(fontSize: 18)),
                        TextFormField(
                          validator: MultiValidator([
                            EmailValidator(errorText: "Email not correct"),
                            RequiredValidator(
                                errorText: "Please enter your email")
                          ]),
                          onSaved: (var email) {
                            myStorage.email = email;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Name", style: TextStyle(fontSize: 18)),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "Please enter your name"),
                          onSaved: (var sname) {
                            myStorage.sname = sname;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Family Name", style: TextStyle(fontSize: 18)),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "Please enter your familyname"),
                          onSaved: (var fname) {
                            myStorage.fname = fname;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Gender", style: TextStyle(fontSize: 18)),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "Please enter your gender"),
                          onSaved: (var sgender) {
                            myStorage.sgender = sgender;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Age", style: TextStyle(fontSize: 18)),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "Please enter your age"),
                          onSaved: (var sage) {
                            myStorage.sage = sage;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Birth", style: TextStyle(fontSize: 18)),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "Please enter your birthday"),
                          onSaved: (var sbirth) {
                            myStorage.sbirth = sbirth;
                          },
                          keyboardType: TextInputType.datetime,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Tel", style: TextStyle(fontSize: 18)),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "Please enter your phone number"),
                          onSaved: (var stel) {
                            myStorage.stel = stel;
                          },
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              child: Text(
                                "SAVE",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await _addprofileCollection.add({
                                    "email": myStorage.email,
                                    "sname": myStorage.sname,
                                    "fname": myStorage.fname,
                                    "sgender": myStorage.sgender,
                                    "sage": myStorage.sage,
                                    "sbirth": myStorage.sbirth,
                                    "stel": myStorage.stel
                                  });
                                  formKey.currentState!.reset();
                                }
                              }),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text("BACK",style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return WelcomeScreen();
                              }));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
