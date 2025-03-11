import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/presentation/pages/downloads/screen_my_netflix.dart';

import 'package:netflix_clone/presentation/pages/home/screen_home.dart';
import 'package:netflix_clone/presentation/pages/main_page/widgets/bottom_navigation.dart';
import 'package:netflix_clone/presentation/pages/news_and_hot/screen_news_and_hot.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});
  final _pages = [
    const ScreenHome(),
    const ScreenNewsAndHot(),
    // const ScreenFastLaughs(),
    // const ScreenSearch(),
    const ScreenDownload(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: indexChangeNotifier,
            builder: (context, int value, _) {
              return _pages[value];
            }),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
