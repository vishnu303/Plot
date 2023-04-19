import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/bloc/cubit/category_items_cubit.dart';
import 'package:plot/screens/add_post_screen.dart';

class DropDownCategory extends StatefulWidget {
  const DropDownCategory({super.key});

  @override
  State<DropDownCategory> createState() => _DropDownCategoryState();
}

class _DropDownCategoryState extends State<DropDownCategory> {
  String? dropDownValue;
  List items = ['item 1', 'item 2', 'item 3', 'item 4'];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DropdownButton<String>(
          hint: const Text('select category of item'),
          isDense: true,
          isExpanded: true,
          value: dropDownValue,
          elevation: 20,
          items: items
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(e),
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            debugPrint(value);
            context.read<CategoryItemsCubit>().getvalue(value!);
            setState(() {
              dropDownValue = value;
            });
          }),
    );
  }
}
