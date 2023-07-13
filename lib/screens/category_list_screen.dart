import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/bloc/category_bloc/category_bloc.dart';
import 'package:plot/screens/category_result_screen.dart';

class CategoryListScreen extends StatelessWidget {
  CategoryListScreen({super.key});

  final List<String> _items = [
    'For Sale: Houses & Apartments',
    'For Rent: Houses & Apartments',
    'Lands & Plots',
    'For Rent: Shops & Offices'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Property Classifications',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_items[index]),
            onTap: () {
              BlocProvider.of<CategoryBloc>(context)
                  .add(GetCategory(categoryQuery: _items[index]));
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                        categoryName: _items[index],
                      )));
            },
          );
        },
        itemCount: _items.length,
      ),
    );
  }
}
