import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stream_nest/features/home/view/home_view.dart';
import 'package:stream_nest/features/login/service/login_service.dart';
import 'package:stream_nest/register_service.dart';
import 'package:stream_nest/register_view.dart';
// import 'package:stream_nest/login_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 150),
                    Text(
                      'StreamNest',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Sign into your account to continue'),
                    SizedBox(height: 50),
                    Container(
                      height: 300,
                      width: 300,

                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          TextField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_outlined),
                              hintText: 'Enter your email',
                              labelText: 'Email Address',
                              labelStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _password,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline),
                              hintText: 'Enter your password',
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.grey),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Container(
                              //   height: 30,
                              //   width: 135,
                              //   //    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color:Colors.black,),
                              //   child: TextButton(
                              //     onPressed: () {
                              //       // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Home2() ));
                              //     },
                              //     child: Text(
                              //       'EXPLORE AS GUEST',
                              //       style: TextStyle(
                              //         fontSize: 10,
                              //         color: Colors.red,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                height: 20,
                                width: 2,
                                color: Colors.black,
                              ),
                              Container(
                                height: 30,
                                width: 120,

                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterView(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'CREATE ACCOUNT',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),

                          Container(
                            height: 35,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                await LoginService().login(
                                  context: context,
                                  email: _email.text,
                                  password: _password.text,
                                );
                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
