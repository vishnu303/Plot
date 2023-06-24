import 'package:flutter/material.dart';
import 'package:plot/model/post_model.dart';
import 'package:plot/screens/post_details_screen.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    //ads card
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        color: Colors.blue,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PostDetailsScreen(
                        post: post,
                      )));
            },
            child: GridTile(
                footer: Container(
                  color: Colors.white,
                  child: ListTile(
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    )),
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(post.userAvatarUrl),
                    ),
                    title: Text(
                      "\$ ${post.price}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      post.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    trailing: const Icon(Icons.favorite_border_outlined),
                  ),
                ),
                child: Image.network(
                  post.thumbnailUrl,
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
