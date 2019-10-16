import 'package:block_pattern_demo/HomePage.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {

  bool _passwordVisible = true;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      
              appBar: AppBar(
                title: Text('fire bloc'),
              ),
              body:SingleChildScrollView(
                child: Container(
                  child:
                  Column(
                    children: <Widget>[
                      SizedBox(height: 40,),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child:
                        TextFormField(
                          controller: _emailController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            //   hintText: 'User Name',
                            labelText: "user",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          obscureText: _passwordVisible,
                          controller: _passwordController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
//                        border: OutlineInputBorder(borderRadius: BorderRadius
//                            .circular(20.0),
//                        ),
                            //  hintText: 'Password',
                            labelText: "password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible ? Icons.visibility : Icons
                                    .visibility_off, color: Theme
                                  .of(context)
                                  .primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = ! _passwordVisible;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                              elevation: 5.0,
                              child: Text('Sign in',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),
                              ),
                              splashColor: Colors.pinkAccent,
                              onPressed: () async {

                                try {
                                  final FirebaseUser user = (await _auth
                                      .signInWithEmailAndPassword(
                                    email: _emailController.text.toString(),
                                    password: _passwordController.text
                                        .toString(),
                                  )).user;
                                  var user1 = _auth.currentUser();
                                  user1.then((data) {
                                    // print("$data");
                                    if (data.uid != null ) {
                                
                                  
                                      print(" Email details ----------------->>>>>>>>>> $data");
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                                    }
                                    else {
                                      print(
                                          'invalid user ----------------->>>>>>>>  $e');
                                    }
                                  });
                                  // debugPrint("login successfully firebase  ");
                                }
                                catch (e) {
                                  debugPrint(
                                      "login failed firebase ---------------->>>>>>>  $e");
                                }
                              }
                          ),
                          SizedBox(height: 40),
                          RaisedButton(
                              elevation: 5.0,
                              child: Text('Register',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),),
                              splashColor: Colors.green,
                              onPressed: () {
                                registerUser();
                              }
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
  }

  registerUser() async {
//      debugPrint("email  ${_emailController.text}");
//      debugPrint("password  ${_passwordController.text}");
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text.toString(),
      password: _passwordController.text.toString(),
    )).user;
  }


}
