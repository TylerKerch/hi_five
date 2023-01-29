import 'package:flutter/material.dart';
import 'package:hi_five/screens/signup_screen.dart';
import 'package:hi_five/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailInputController;
  late TextEditingController _passwordInputController;

  @override
  void initState() {
    _emailInputController = TextEditingController();
    _passwordInputController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Form(
            child: Stack(
              children: [
                SizedBox(
                  width: width,
                  height: height * 0.01,
                ),
                Positioned(
                  top: height * 0.3,
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
                                    ' In',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0,
                                        color: Colors.blue.shade200),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: const Color(0xffF8F8F8),
                                ),
                                height: height * 0.055,
                                width: width * 0.7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: TextFormField(
                                      controller: _emailInputController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                          'Email Address',
                                          hintStyle: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                            //color: StyleConstants.darkPurpleGrey)),
                                            color: Color(0xffbfbfbf),
                                          )),
                                      style: const TextStyle(color: Colors.black),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
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
                                height: height * 0.06,
                                width: width * 0.7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: Row(
                            children: const [
                              Spacer(),
                              Text(
                                'Forgot Password?',
                                style: TextStyle(color: Color(0xff939393)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            print(_emailInputController.text);
                            print(_passwordInputController.text);
                            AuthService().signInWithEmail(
                                _emailInputController.text,
                                _passwordInputController.text);
                          },
                          child: Container(
                            height: height * 0.06,
                            width: width * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color:  const Color(0xff9ed4ff)
                            ),
                            child: const Center(
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                child: const Text('Signup'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SignUpScreen(),
                                    ),
                                  );
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