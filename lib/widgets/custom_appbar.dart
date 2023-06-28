import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          const Text(
            'Explore',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
                size: 25,
              ))
        ],
      ),
      snap: false,
      pinned: true,
      floating: true,
      expandedHeight: 150,
      bottom: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          color: Colors.white,
          height: 50,
          child: const TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
