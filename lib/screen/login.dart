import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:soft_dev/model/profile.dart';
import 'package:soft_dev/screen/welcome.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

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
                title: Text("Log in"),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Text("Email", style: TextStyle(fontSize: 18)),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Please enter your email"),
                              EmailValidator(errorText: "Email not correct")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (var email) {
                              profile.email = email!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Password", style: TextStyle(fontSize: 18)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "Please enter your password"),
                            obscureText: true,
                            onSaved: (var password) {
                              profile.password = password!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("Log in",
                                  style: TextStyle(fontSize: 20)),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  try {
                                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: profile.email, 
                                      password: profile.password).then((value){
                                        formKey.currentState!.reset();
                                        Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return WelcomeScreen();
                                      }));
                                      });
                                  } on FirebaseAuthException catch (e) {
                                    
                                    Fluttertoast.showToast(
                                        msg: e.message!,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.red);
                                  }
                                }
                              },
                            ),
                          ),
                          SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text("BACK",style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomeScreen();
                              }));
                            },
                          ),
                        ),
                        ],
                      ),
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