import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:deviginite_app/screens/register_screen.dart';
// import 'package:deviginite_app/services/Authentication.dart';
import 'package:deviginite_app/utils/app_constants.dart';
import 'package:deviginite_app/utils/button.dart';
import 'package:deviginite_app/utils/text_field.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  void signInMethod() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 500,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: AppConstants.darkBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 90,
                        height: 90,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "We WIN",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 35,
                            color: Colors.white),
                      ),
                      //welcome back you have been missed !
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: Colors.grey.shade200,
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                          // border: Border.all(color: AppConstants.themeColor),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Login Now",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            myTextField(
                              controller: emailController,
                              hintText: "Email",
                              obscureText: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myTextField(
                                controller: passwordController,
                                hintText: "Password",
                                obscureText: true),
                            const SizedBox(
                              height: 10,
                            ),

                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: Text("Forgot Password?"),
                                )
                              ],
                            ),

                            //forgot password?
                            const SizedBox(
                              height: 25,
                            ),

                            // MyButton(
                            //   text: "Sign In",
                            //   onTap: () async {
                            //     bool isLoggedIn =
                            //         await Authentication.loginUser(
                            //             emailController.text,
                            //             passwordController.text);

                            //     if (isLoggedIn) {
                            //       Get.toNamed("/userDashboard");
                            //     }
                            //   },
                            // ),
                            // MyButton(
                            //   text: "Sign In",
                            //   onTap: () async {
                            //    Get.toNamed('/searchLocation');
                            //   },
                            // ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Not a member?",
                                  style: TextStyle(fontSize: 18),
                                ),
                                // TextButton(
                                //   onPressed: () {
                                //     Navigator.pushReplacement(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             RegisterPage(),
                                //       ),
                                //     );
                                //   },
                                //   child: const Text(
                                //     "Register now",
                                //     style: TextStyle(
                                //         color: Colors.blue, fontSize: 18),
                                //   ),
                                // )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
