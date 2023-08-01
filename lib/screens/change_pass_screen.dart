import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/bloc/auth_bloc/auth_bloc.dart';

import 'package:plot/widgets/custom_textform.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Change password'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
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
                const Spacer(flex: 1),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      customTextForm(
                        controller: _oldPasswordController,
                        label: 'Current Password',
                        keybordType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "Please enter current password";
                          } else if (value.length < 8) {
                            return "Password must be atleast 8 characters long";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      customTextForm(
                        controller: _passwordController,
                        label: 'New Password',
                        keybordType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "Please enter new password";
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
                        keybordType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "Please re-enter new Password";
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
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is UserUpdateError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Theme.of(context).primaryColor,
                          content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    return Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: Colors.grey,
                                shadowColor: Colors.grey,
                                elevation: 7,
                                backgroundColor: const Color(0xff086788)),
                            onPressed: state is UserUpdating
                                ? () {}
                                : () {
                                    if (_formKey.currentState!.validate()) {}
                                  },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: kIsWeb
                                      ? screenWidth * 0.05
                                      : screenWidth * 0.25,
                                  vertical: 13),
                              child: const Text(
                                'Save',
                                style: TextStyle(fontSize: 16),
                              ),
                            )));
                  },
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
