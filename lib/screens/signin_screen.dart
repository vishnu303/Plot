import 'package:flutter/material.dart';
import 'package:plot/screens/signup_screen.dart';
import 'package:plot/widgets/custom_textform.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   _emailController = TextEditingController();
  //   _passwordController = TextEditingController();
  //   super.initState();
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              const Center(
                child: Text(
                  'Plot',
                  style: TextStyle(
                      color: Color(0xff086788),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              const Text(
                'Login to your Account ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: screenHeight * 0.05),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    customTextForm(
                      controller: _emailController,
                      label: 'Email',
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    customTextForm(
                      controller: _passwordController,
                      label: 'Password',
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.grey,
                      elevation: 7,
                      backgroundColor: const Color(0xff086788)),
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.25, vertical: 13),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have account ? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}