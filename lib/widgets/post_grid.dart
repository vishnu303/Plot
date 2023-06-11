import 'package:flutter/material.dart';
import 'package:plot/model/post_model.dart';
import 'package:plot/widgets/post_card.dart';

class PostGrid extends StatefulWidget {
  final List<Post> post;
  const PostGrid({super.key, required this.post});

  @override
  State<PostGrid> createState() => _PostGridState();
}

class _PostGridState extends State<PostGrid> {
  @override
  Widget build(BuildContext context) {
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
        itemCount: widget.post.length,
        itemBuilder: (context, index) {
          print(widget.post[0].itemCategory);
          return PostCard(
            post: widget.post[index],
          );
        });
  }
}
