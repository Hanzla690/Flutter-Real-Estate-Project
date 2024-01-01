import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/Models/UserModel.dart';
import 'package:flutter_project/User%20Authentication/LoginPage.dart';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

class ResetPassword extends StatefulWidget {
  String email;
  ResetPassword({super.key, required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState(email: email);
}

class _ResetPasswordState extends State<ResetPassword> {
  _ResetPasswordState({required this.email});
  String email;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    auth.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('A Reset Password email has been sent to ${email}'),
      ),
    );
  }

  resetPassword() {
    if (passwordController.text == confirmPasswordController.text) {
    } else {
      showDialog(
          context: context,
          builder: (context) => AboutDialog(
                children: [
                  Text("Passwords dont match"),
                ],
              ));
    }
  }
}

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  int otpCode = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green.shade500,
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.green.shade700,
              Colors.green.shade600,
              Colors.green.shade500
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: ListTile(
                subtitle: TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                leading: const Icon(Icons.email_outlined, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  String email = emailController.text.trim();
                  getOTP();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade400),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(color: Colors.white),
                  ),
                ),
                child: const Text(
                  'Send OTP',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: ListTile(
                subtitle: TextField(
                  controller: otpController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: 'Enter OTP',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                leading: const Icon(Icons.email_outlined, color: Colors.white),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  String enteredOTP = otpController.text.trim();

                  if (enteredOTP == otpCode.toString()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: ((context) => Login())),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Can\'t verify OTP'),
                        content: Text('Incorrect OTP'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade400),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(color: Colors.white),
                  ),
                ),
                child: const Text(
                  'Verify OTP',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getOTP() async {
    if (emailController.text.isNotEmpty) {
      otpCode = generateOTP();
      try {
        final mailer = Mailer(
            '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');
        final toAddress = Address(emailController.text.trim());
        debugPrint(emailController.text.trim());
        final fromAddress = Address('insightimaan@gmail.com');
        final content = Content('text/plain',
            'Hello! Welcome to Pak Homes!\nYour One-Time-Password (OTP) code is $otpCode');
        final subject = 'OTP Verification for Pak Homes';
        final personalization = Personalization([toAddress]);

        final email =
            Email([personalization], fromAddress, subject, content: [content]);
        final result = await mailer.send(email);
        debugPrint('RESULT: $result');
      } catch (e) {
        debugPrint('Error sending email: $e');
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Can\'t send Email'),
          content: Text('Email field can\'t be empty'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  int generateOTP() {
    Random random = Random();
    int otp = random.nextInt(9000) + 1000;
    return otp;
  }
}
