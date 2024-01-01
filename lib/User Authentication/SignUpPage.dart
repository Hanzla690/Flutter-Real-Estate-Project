import 'package:flutter/material.dart';
import 'package:flutter_project/HomePage.dart';
import 'package:flutter_project/User%20Authentication/LoginPage.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:flutter_project/Models/UserModel.dart';
import 'package:lottie/lottie.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final UserAuthentication auth = UserAuthentication();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green.shade500,
        //toolbarHeight: 60,
        title: const Text(
          "Signup",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.green.shade700,
            Colors.green.shade600,
            Colors.green.shade500
          ])),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Lottie.asset(
                      ("assets/animationS.json"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  // child: TextField(
                  //   controller: usernameController,
                  //   decoration: InputDecoration(hintText: 'Username'),
                  // ),
                  child: ListTile(
                    // title: const Text("Price/Demand (PKR)"),
                    subtitle: TextField(
                      controller: usernameController,
                      style: const TextStyle(color: Colors.white),
                      // keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          hintText: 'Full Name',
                          hintStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    leading: const Icon(Icons.verified_user_outlined,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  // child: TextField(
                  //   controller: emailController,
                  //   decoration: InputDecoration(hintText: 'Email'),
                  // ),
                  child: ListTile(
                    // title: const Text("Price/Demand (PKR)"),
                    subtitle: TextField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      // keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    leading:
                        const Icon(Icons.email_outlined, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  // child: TextField(
                  //   controller: passwordController,
                  //   decoration: InputDecoration(hintText: 'Password'),
                  // ),
                  child: ListTile(
                    // title: const Text("Price/Demand (PKR)"),
                    subtitle: TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      // keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    leading: const Icon(Icons.password_outlined,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // ElevatedButton(onPressed: _signUp, child: Text('Sign Up')),
                ElevatedButton(
                  onPressed: _signUp,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green.shade400),
                      side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: Colors.white))),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(color: Colors.white)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: const Text("Login Now!",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white)),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                const Text(
                  "©PakHomes Private Limited",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 10),
                )
              ]),
        ),
      ),
    );
  }

  void _signUp() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Couldn\'t create account'),
          content: Text('Fields can\'t be empty'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'))
          ],
        ),
      );
      return;
    }

    showLoadingDialog();
    String result = await auth.signupWithEmail(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text);
    Navigator.pop(context);

    if (result.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Couldn\'t create account'),
          content: Text(result),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'))
          ],
        ),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents user from dismissing dialog by tapping outside
      builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.3, // Adjust the opacity as needed
              child: const ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      },
    );
  }
}
