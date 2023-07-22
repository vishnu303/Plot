import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/screens/error_screen.dart';

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
                if (state.post.isNotEmpty) {
                  return PostGrid(post: state.post);
                } else {
                  return ErrorScreen(
                    onPressed: () {
                      BlocProvider.of<PostBloc>(context).add(GetPosts());
                    },
                  );
                }
              } else if (state is PostInitial) {
                return Center(
                  child: LinearProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              } else {
                return Container();
                // return ErrorScreen(
                //   onPressed: () {
                //     BlocProvider.of<PostBloc>(context).add(GetPosts());
                //   },
                // );
              }
            },
          )
        ])),
      ],
    );
  }
}
