import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plot/widgets/custom_appbar.dart';

import 'package:plot/widgets/post_grid.dart';

import '../bloc/post_bloc/post_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<PostBloc>(context).add(GetPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomAppbar(),
        SliverList(
            delegate: SliverChildListDelegate([
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostLoaded) {
                return PostGrid(post: state.post);
              } else if (state is PostLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else {
                return Container(
                  color: Colors.yellow,
                );
              }
            },
          )
        ])),
      ],
    );
  }
}
