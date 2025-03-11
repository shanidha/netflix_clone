import 'package:flutter/material.dart';
import 'package:netflix_clone/presentation/pages/fast_laughs/widgets/video_list_item.dart';

import '../../../core/colors/colors.dart';

class ScreenFastLaughs extends StatelessWidget {
  const ScreenFastLaughs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: PageView(
        scrollDirection: Axis.vertical,
        children: List.generate(
            10,
            (index) => VideoListItemWidget(
                  index: index,
                )),
      )),
    );
  }
}
