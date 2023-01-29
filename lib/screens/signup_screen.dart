import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hi_five/models/Emp.dart';
import 'package:hi_five/providers/UserProvider.dart';
import 'package:hi_five/services/auth_service.dart';
import 'package:hi_five/services/signup_validators.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _nameInputController;
  late TextEditingController _emailInputController;
  late TextEditingController _passwordInputController;
  File? _profilePic;
  bool _loading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameInputController = TextEditingController();
    _emailInputController = TextEditingController();
    _passwordInputController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    ImageProvider image = const AssetImage('assets/Picolas.png');

    if (_profilePic != null) {
      image = FileImage(_profilePic!);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                SizedBox(
                  width: width,
                  height: height * 0.01,
                ),
                Positioned(
                  top: height * 0.2,
                  child: SizedBox(
                    width: width,
                    child: Column(
                      children: [
                        SizedBox(
                          width: width * 0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Sign',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    ' Up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0,
                                        color: Colors.blue.shade200),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              SizedBox(
                                width: width * 0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        //color: Colors.white,
                                        color: const Color(0xffF8F8F8),
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                      ),
                                      width: width * 0.7,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0),
                                        child: Center(
                                          child: TextFormField(
                                              controller: _nameInputController,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Full Name',
                                                  hintStyle: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.w600,
                                                      //color: StyleConstants.darkPurpleGrey)
                                                      color: Color(0xffbfbfbf))),
                                              style: const TextStyle(color: Colors.black)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: const Color(0xffF8F8F8),
                                ),
                                width: width * 0.7,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Center(
                                    child: TextFormField(
                                        controller: _emailInputController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Email Address',
                                            hintStyle: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              //color: StyleConstants.darkPurpleGrey)),
                                              color: Color(0xffbfbfbf),
                                            )),
                                        style: const TextStyle(color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  //color: Colors.white,
                                  color: const Color(0xffF8F8F8),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                width: width * 0.7,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Center(
                                    child: TextFormField(
                                        controller: _passwordInputController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Password',
                                            hintStyle: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                                //color: StyleConstants.darkPurpleGrey)
                                                color: Color(0xffbfbfbf))),
                                        obscureText: true,
                                        style: const TextStyle(color: Colors.black)
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        !_loading
                            ? GestureDetector(
                          onTap: () async {
                            setState(() {
                              _loading = true;
                            });
                            String? snackbarError =
                            await SignupValidators.validate(
                                _passwordInputController.text.trim(),
                                _emailInputController.text.trim());

                            bool valid = false;

                            if (snackbarError == null) {
                              valid = await AuthService().signUpWithEmail(
                                  _nameInputController.text.trim(),
                                  _emailInputController.text.trim(),
                                  _passwordInputController.text.trim());
                            }
                            if (valid && snackbarError == null) {

                              Emp emp = Emp(
                                  _nameInputController.text.trim(),
                                  _emailInputController.text.trim());

                              await AuthService.createUser(emp);
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                _loading = false;
                              });
                              SnackBar s = SnackBar(
                                  content: Text(snackbarError ??
                                      "Enter a valid email"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(s);
                            }
                          },
                          child: Container(
                            height: height * 0.06,
                            width: width * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: const Color(0xff9ed4ff)
                            ),
                            child: const Center(
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        )
                            : const CircularProgressIndicator(),
                        SizedBox(
                          width: width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?'),
                              TextButton(
                                child: const Text('Login'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
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
        ),
      ),
    );
  }
}