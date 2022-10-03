import 'package:flutter/cupertino.dart';

import 'package:plot/Layout/mobile_screen_layout.dart';
import 'package:plot/Layout/web_screen_layout.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return const WebLayout();
      }
      return const MobileLayout();
    });
  }
}
