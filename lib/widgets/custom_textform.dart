import 'package:flutter/material.dart';

Widget customTextForm({controller, label, validate}) {
  return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        border: const OutlineInputBorder(),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
      ),
      validator: validate);
}
