import 'package:flutter/material.dart';
import 'package:water_tech/controller/Authentication/firebase_auth_services.dart';
import 'package:water_tech/view/pages/profile_pages.dart';
import 'package:water_tech/view/tools/MyTextStyle.dart';
import 'package:water_tech/view/tools/my_button.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _auth = FirebaseAuthService();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Reset Password', style: blacksmalltext),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'Enter Your Valued Email',
            style: blacktextStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
              controller: emailController,
              labeltxt: 'Email',
              icon: Icons.email),
          MyButton(
              txt: 'Send Email',
              ontap: () async {
                await _auth.resetPassword(emailController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'An email for password reset has been sended your email')),
                );
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
