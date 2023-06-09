import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/widgets/post_card.dart';

import '../bloc/post_bloc/post_bloc.dart';

class PostGrid extends StatefulWidget {
  const PostGrid({super.key});

  @override
  State<PostGrid> createState() => _PostGridState();
}

class _PostGridState extends State<PostGrid> {
  @override
  void initState() {
    BlocProvider.of<PostBloc>(context).add(GetPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoaded) {
          return GridView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //     maxCrossAxisExtent: 500,
              //     childAspectRatio: 1.3,
              //     mainAxisSpacing: 15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.3,
              ),
              itemCount: state.post.length,
              itemBuilder: (context, index) {
                print(state.post[0].itemCategory);
                return PostCard(
                  post: state.post[index],
                );
              });
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
    );
  }
}
