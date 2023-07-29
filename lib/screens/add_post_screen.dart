import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plot/bloc/category_dopdown_cubit/category_items_cubit.dart';

import 'package:plot/bloc/post_bloc/post_bloc.dart';
import 'package:plot/model/user_model.dart';
import 'package:plot/widgets/custom_textform.dart';
import 'package:plot/widgets/drop_down_category.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({
    super.key,
  });

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late TextEditingController _phoneNoController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
    _phoneNoController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _phoneNoController.dispose();
    super.dispose();
  }

  final ImagePicker _imagePicker = ImagePicker();
  List<File> imageFileList = [];
  UserModel? _userData;

  //select images
  void selectImage() async {
    final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
    debugPrint(' images ${selectedImages.length}');

    if (selectedImages.isNotEmpty) {
      imageFileList = selectedImages.map((element) {
        return File(element.path);
      }).toList();
      setState(() {});
    }
  }

//get username from firebase firestore
  Future<void> getUsername() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();

    setState(() {
      _userData = UserModel.fromMap(documentSnapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'What do you want to sell ?',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const DropDownCategory(),
                const SizedBox(height: 20),
                customTextForm(
                  controller: _titleController,
                  label: 'Title',
                  textInputAction: TextInputAction.next,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Please fill title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  minLines: 1,
                  textInputAction: TextInputAction.next,
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                customTextForm(
                  controller: _phoneNoController,
                  keybordType: TextInputType.phone,
                  label: 'Phone Number',
                  textInputAction: TextInputAction.next,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Please fill phone number ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                customTextForm(
                  controller: _priceController,
                  keybordType: TextInputType.number,
                  label: 'Price',
                  textInputAction: TextInputAction.next,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the amount you expecting';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                customTextForm(
                  controller: _locationController,
                  keybordType: TextInputType.text,
                  label: 'Location',
                  textInputAction: TextInputAction.done,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => selectImage(),
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  child: Container(
                    width: width,
                    height: height * 0.2,
                    decoration: BoxDecoration(
                        //color: Colors.blue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18)),
                        border: Border.all(color: Colors.black)),
                    child: imageFileList.isEmpty
                        ? const Center(
                            child: Text(
                            'Upload Photos',
                            style: TextStyle(fontSize: 20),
                          ))
                        : ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18)),
                            child: Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.center,
                              children: [
                                Image.file(
                                  imageFileList[0],
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  color: Colors.black38,
                                  child: Center(
                                    child: Visibility(
                                      visible: imageFileList.length > 1,
                                      child: Text(
                                        '+ ${imageFileList.length - 1}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<CategoryItemsCubit, String>(
                  builder: (context, categoryItem) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () async {
                          await getUsername();
                          debugPrint(categoryItem);
                          if (!mounted) return;
                          if (_formKey.currentState!.validate()) {
                            if (imageFileList.isNotEmpty) {
                              if (categoryItem.isNotEmpty) {
                                context.read<PostBloc>().add(
                                      UploadPostRequest(
                                        username: _userData!.username,
                                        userAvatarUrl: _userData!.photoUrl,
                                        title: _titleController.text,
                                        description:
                                            _descriptionController.text,
                                        location: _locationController.text,
                                        phoneNo: _phoneNoController.text,
                                        price: int.parse(_priceController.text),
                                        images: imageFileList,
                                        itemCategory: categoryItem,
                                      ),
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        content: const Text(
                                            'Select the item you want to sell')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      content: const Text(
                                          'Select images you want to upload')));
                            }
                          }
                        },
                        child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 60),
                            child: Text(
                              'Save',
                              style: TextStyle(fontSize: 18),
                            )));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
