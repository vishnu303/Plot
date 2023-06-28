import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/post_model.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;
  const PostDetailsScreen({super.key, required this.post});

//make phone call
  void _makingPhoneCall() async {
    var url = Uri.parse("tel:${post.phoneNo}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong !!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(0xff086788),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,##,000');
    var date = DateFormat.yMMMd().format(post.datePublished);
    var priceFormatted = formatter.format(post.price);
    final PageController controller = PageController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopCarousal(controller: controller, post: post),
            PriceCard(priceFormatted: priceFormatted, post: post, date: date),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.message),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Chat',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Text(
                'Posted By',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(post.userAvatarUrl)),
                  title: Text(
                    post.username,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 50),
              child: ReadMoreText(
                post.description,
                trimLines: 2,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                lessStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              _makingPhoneCall();
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.phone,
                    size: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Call',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PriceCard extends StatelessWidget {
  const PriceCard({
    super.key,
    required this.priceFormatted,
    required this.post,
    required this.date,
  });

  final String priceFormatted;
  final Post post;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.indianRupeeSign,
                  size: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  priceFormatted,
                  style: const TextStyle(fontSize: 30),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  post.location,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const Spacer(),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TopCarousal extends StatelessWidget {
  const TopCarousal({
    super.key,
    required this.controller,
    required this.post,
  });

  final PageController controller;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: controller,
            itemBuilder: (context, index) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: post.imageUrls![index],
                    placeholder: (context, url) => Container(
                      color: const Color(0xffD3D3D3),
                    ),
                  ));
            },
            itemCount: post.imageUrls!.length,
          ),
        ),
        Positioned(
            bottom: 10,
            right: 160,
            child: SmoothPageIndicator(
              controller: controller, // PageController
              count: post.imageUrls!.length,
              effect: const ExpandingDotsEffect(
                  activeDotColor: Color(0xff086788),
                  expansionFactor: 3,
                  dotHeight: 10,
                  dotWidth: 10), // your preferred effect
            ))
      ],
    );
  }
}
