import 'package:flutter/material.dart';
import 'package:flutter_project/HomePage.dart';
import 'package:flutter_project/User%20Authentication/SignUpPage.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:flutter_project/Models/UserModel.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UserAuthentication auth = UserAuthentication();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green.shade500,
        //toolbarHeight: 60,
        title: const Text("PakHomes Login",
              style: TextStyle(
                  color: Colors.white70
              ),),
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
              ])
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Padding(
                padding: const EdgeInsets.only(top: 15, left: 25, right: 15),
                child: Container(
                  height: 200,
                  width: 200,
                  child: Lottie.asset("assets/animation4.json",
                  fit: BoxFit.cover)
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: ListTile(
                 // title: const Text("Price/Demand (PKR)"),
                  subtitle: TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white70),
                   // keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2,
                              color: Colors.white70),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )),
                  ),
                  leading: const Icon(Icons.email_outlined,
                    color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                // child: TextField(
                //   controller: passwordController,
                //  // obscureText: true,
                //   decoration: InputDecoration(hintText: 'Password'),
                // ),
                child: ListTile(
                  // title: const Text("Price/Demand (PKR)"),
                  subtitle: TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white70),
                    // keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2,
                              color: Colors.white70),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )),
                  ),
                  leading: const Icon(Icons.password_outlined,
                    color: Colors.white70),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: _login,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade400),
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Colors.white70))
                ),
                  child: const Text('Log In',
                  style: TextStyle(
                    color: Colors.white70
                  ),),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",
                      style: TextStyle(
                        color: Colors.white70
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                        context, MaterialPageRoute(
                          builder: (context)=> const SignUp()));
                      },
                    child: const Text("Signup Now!",
                    style: TextStyle(
                        color: Colors.white70,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white70
                    )),
                  )
                ],
              )
            ]),
      ),
    );
  }

  void _login() async {
    await auth.loginWithEmail(
        email: emailController.text, password: passwordController.text);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
  }
}
