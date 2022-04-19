import 'package:flutter/material.dart';
import 'package:soft_dev/screen/login.dart';
import 'package:soft_dev/screen/register.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Street Food", style: TextStyle(fontSize: 30),),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/picapp.png"),
              SizedBox(
                height: 15,
              ),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return RegisterScreen();
                      }));
                    },
                    icon: Icon(Icons.add),
                    label: Text("Sign up", style: TextStyle(fontSize: 20))),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    icon: Icon(Icons.login),
                    label: Text("Log In", style: TextStyle(fontSize: 20))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
