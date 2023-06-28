import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/bloc/auth_bloc/auth_bloc.dart';
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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).primaryColor,
                content: Text(state.error)));
          }
        },
        child: SafeArea(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            padding: const EdgeInsets.symmetric(horizontal: kIsWeb ? 500 : 30),
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
                        validate: (value) {
                          if (value.isEmpty ||
                              !RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                                  .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      customTextForm(
                          controller: _passwordController,
                          label: 'Password',
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter the password';
                            }
                            return null;
                          }),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(SignInRequest(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ));
                      }
                      //FirebaseAuth.instance.currentUser!.reload();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              kIsWeb ? screenWidth * 0.05 : screenWidth * 0.25,
                          vertical: 13),
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
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
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
      ),
    );
  }
}
