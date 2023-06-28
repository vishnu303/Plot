import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/widgets/post_grid.dart';

import '../bloc/category_bloc/category_bloc.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoaded) {
            if (state.post.isNotEmpty) {
              return PostGrid(post: state.post);
            } else {
              return const Center(
                child: Text('No result'),
              );
            }
          } else if (state is CategoryLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return Container(
              color: Colors.yellow,
            );
          }
        },
      ),
    );
  }
}
