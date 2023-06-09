import 'package:flutter/material.dart';
import 'package:plot/screens/add_post_screen.dart';
import 'package:plot/screens/category_screen.dart';
import 'package:plot/screens/chat_screen.dart';
import 'package:plot/screens/home_screen.dart';
import 'package:plot/screens/menu_screen.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int _page = 0;

  late final PageController _pageController;

  // controlling home pages
  void changePage(int page) {
    _pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeScreen(),
            ChatScreen(),
            AddPostScreen(),
            CategoryScreen(),
            MenuScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        onTap: changePage,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: _page,
        items: [
          BottomNavigationBarItem(
            icon: _page == 0
                ? const Icon(Icons.home_rounded)
                : const Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _page == 1
                ? const Icon(Icons.email_rounded)
                : const Icon(Icons.email_outlined),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: _page == 2
                ? const Icon(Icons.add_circle_rounded)
                : const Icon(Icons.add_circle_outline),
            label: 'Create Post',
          ),
          BottomNavigationBarItem(
            icon: _page == 3
                ? const Icon(Icons.layers_rounded)
                : const Icon(Icons.layers_outlined),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
