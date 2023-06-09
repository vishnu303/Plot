import 'package:flutter/material.dart';

import 'package:plot/widgets/custom_appbar.dart';

import 'package:plot/widgets/post_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomAppbar(),
        SliverList(
            delegate: SliverChildListDelegate([
          const PostGrid(),
        ])),
      ],
    );
  }
}
