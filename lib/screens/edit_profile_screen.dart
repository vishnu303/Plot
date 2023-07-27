import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plot/bloc/auth_bloc/auth_bloc.dart';

import 'package:plot/widgets/custom_textform.dart';

class EditProfileScreen extends StatefulWidget {
  final String photoUrl;
  final String username;
  final String email;
  const EditProfileScreen(
      {super.key,
      required this.photoUrl,
      required this.username,
      required this.email});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  @override
  void initState() {
    _emailController.text = widget.email;
    _usernameController.text = widget.username;

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();

    _usernameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Edit Profile'),
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
                          backgroundColor: Colors.white,
                          backgroundImage: _image == null
                              ? NetworkImage(widget.photoUrl)
                              : Image.file(_image!).image,
                        ),
                        const Positioned(
                          right: 0,
                          bottom: -4,
                          child: Icon(
                            Icons.add_circle_outlined,
                            color: Colors.black,
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
                        keybordType: TextInputType.text,
                        textInputAction: TextInputAction.next,
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
                        keybordType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validate: (value) {
                          if (value.isEmpty ||
                              !RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                                  .hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
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
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<AuthBloc>(context).add(
                                          UpdateUserData(
                                              email: _emailController.text,
                                              username:
                                                  _usernameController.text));
                                    }
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
