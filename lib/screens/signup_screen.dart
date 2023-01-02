import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plot/bloc/auth_bloc/auth_bloc.dart';
import 'package:plot/screens/signin_screen.dart';
import 'package:plot/widgets/custom_textform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;

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
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });

    // if (!mounted) return;
    // context.read<StorageBloc>().add(PickImage(
    //     childName: 'ProfilePic',
    //     file: await image!.readAsBytes(),
    //     isPost: false));
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            padding: const EdgeInsets.symmetric(horizontal: kIsWeb ? 400 : 30),
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
                SizedBox(height: screenHeight * 0.05),
                const Text(
                  'Create your Account ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: _image == null
                              ? const NetworkImage(
                                  'https://images.pexels.com/photos/10528612/pexels-photo-10528612.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')
                              : Image.file(_image!).image,
                        ),
                        const Positioned(
                          right: 0,
                          bottom: 0,
                          child: Icon(
                            Icons.add_circle_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      customTextForm(
                        controller: _usernameController,
                        label: 'Name',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      customTextForm(
                        controller: _emailController,
                        label: 'Email',
                        validate: (value) {
                          if (value.isEmpty ||
                              !RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                                  .hasMatch(value!)) {
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
                            return "Please Enter New Password";
                          } else if (value.length < 8) {
                            return "Password must be atleast 8 characters long";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      customTextForm(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        validate: (value) {
                          if (value.isEmpty) {
                            return "Please Re-Enter New Password";
                          } else if (value.length < 8) {
                            return "Password must be atleast 8 characters long";
                          } else if (value != _passwordController.text) {
                            return "Password must be same as above";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: screenHeight * 0.05),
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.grey,
                          elevation: 7,
                          backgroundColor: const Color(0xff086788)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(SignUpRequest(
                              email: _emailController.text,
                              password: _passwordController.text,
                              username: _usernameController.text,
                              image: _image!));
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: kIsWeb
                                ? screenWidth * 0.05
                                : screenWidth * 0.25,
                            vertical: 13),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                ),
                const Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do you have an account ? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          'Sign In',
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
