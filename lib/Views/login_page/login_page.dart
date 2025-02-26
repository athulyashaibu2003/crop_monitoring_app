import 'package:crop_monitoring_app_orginal/Views/bottom_navigation_bar_screen/bottom_nav_bar.dart';
import 'package:crop_monitoring_app_orginal/components/my_button/my_button.dart';
import 'package:crop_monitoring_app_orginal/components/my_textfield/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  //tap to go to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  // email and password textediting controller
  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passwordcontroller = TextEditingController();
  //login logic
  void login(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BottomNavScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Image.asset("assets/images/mobile-phone_1143973.png", height: 100),
            // Icon(icons.message, size: 60, color: Colors.blue),
            SizedBox(height: 40),
            //welcome back message
            Text(
              "Welcome back, you've been missed",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 30),

            //email textfield
            MyTextfield(
              hintText: "Email",
              obscureText: false,
              controller: _emailcontroller,
            ),
            SizedBox(height: 10),
            //pw textfield
            MyTextfield(
              hintText: "Password",
              obscureText: true,
              controller: _passwordcontroller,
            ),
            SizedBox(height: 10),
            //login button
            MyButton(onTap: () => login(context), text: "Login"),
            //register now
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member? ", style: TextStyle(color: Colors.black)),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register Now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
