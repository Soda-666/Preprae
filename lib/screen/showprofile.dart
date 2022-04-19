import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soft_dev/screen/welcome.dart';

class ShowprofileScreen extends StatefulWidget {
  @override
  _ShowprofileScreenState createState() => _ShowprofileScreenState();
}

class _ShowprofileScreenState extends State<ShowprofileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Show Profile")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("addprofile").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("Email : " + document["email"]),
                          Text("Name : " +
                              document["sname"] +
                              "  " +
                              document["fname"]),
                          Text("Gender : " + document["sgender"]),
                          Text("Age : " + document["sage"]),
                          Text("BirthDay : " + document["sbirth"]),
                          Text("Tel : " + document["stel"]),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                "BACK",
                                style: TextStyle(fontSize: 20),
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
                      )));
            }).toList(),
          );
        },
      ),
    );
  }
}
