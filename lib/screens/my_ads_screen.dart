import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/screens/error_screen.dart';
import 'package:plot/widgets/post_grid.dart';

import '../bloc/post_bloc/post_bloc.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  void initState() {
    context.read<PostBloc>().add(GetMyPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ads'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoaded) {
            return PostGrid(post: state.post);
          } else if (state is PostLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          } else {
            return const ErrorScreen();
          }
        },
      ),
    );
  }
}
