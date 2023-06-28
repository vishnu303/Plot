import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:plot/model/post_model.dart';
import 'package:plot/screens/post_details_screen.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,##,000');
    var priceFormatted = formatter.format(post.price);
    //ads card
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        color: Colors.white,
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
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(post.userAvatarUrl),
                  ),
                  title: Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.indianRupeeSign,
                        size: 12,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        priceFormatted,
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    post.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.black),
                  ),
                  trailing: const Icon(Icons.favorite_border_outlined),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: post.thumbnailUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: const Color(0xffD3D3D3),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Text('Something went wrong !!!'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
