import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/bloc/category_dopdown_cubit/category_items_cubit.dart';

class DropDownCategory extends StatefulWidget {
  const DropDownCategory({super.key});

  @override
  State<DropDownCategory> createState() => _DropDownCategoryState();
}

class _DropDownCategoryState extends State<DropDownCategory> {
  String? dropDownValue;
  List<String> items = [
    'For Sale: Houses & Apartments',
    'For Rent: Houses & Apartments',
    'Lands & Plots',
    'For Rent: Shops & Offices'
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DropdownButton<String>(
          hint: const Text('select the item you want to sell'),
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
