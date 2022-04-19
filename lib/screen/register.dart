import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:soft_dev/model/profile.dart';
import 'home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                title: Text("Register"),
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
                              child: Text("Register",
                                  style: TextStyle(fontSize: 20)),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  try {
                                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                            email: profile.email,
                                            password: profile.password)
                                        .then((value) {
                                      formKey.currentState!.reset();
                                      Fluttertoast.showToast(
                                          msg: "User account has been created.",
                                          gravity: ToastGravity.TOP,
                                          backgroundColor: Colors.black);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HomeScreen();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    print(e.code);
                                    String message;
                                    if (e.code == 'email-already-in-use') {
                                      message =
                                          "There is an email in the system Please use a different email address.";
                                    } else if (e.code == 'weak-password') {
                                      message =
                                          "Password must be at least 6 characters long.";
                                    } else {
                                      message = e.message!;
                                    }
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
