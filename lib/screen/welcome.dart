import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soft_dev/screen/addprofile.dart';
import 'package:soft_dev/screen/home.dart';
import 'package:soft_dev/screen/showprofile.dart';

class WelcomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WELCOME"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              /*AddprofileScreen(),
              ShowprofileScreen(),*/

              Text(
                auth.currentUser!.email!,
                style: TextStyle(fontSize: 25),
              ),
              ElevatedButton(
                child: Text("Add Profile"),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return AddprofileScreen();
                  }));
                },
              ),
              ElevatedButton(
                child: Text("Show Profile"),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return ShowprofileScreen();
                  }));
                },
              ),
              ElevatedButton(
                  child: Text("Log out"),
                  onPressed: () {
                    auth.signOut().then((value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }));
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
