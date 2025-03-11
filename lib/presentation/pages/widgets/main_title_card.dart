import 'package:flutter/material.dart';
import 'package:netflix_clone/core/strings.dart';


import '../../../core/constants.dart';
import '../../../domain/core/models/tile_card_model.dart';

import 'main_card.dart';
import 'main_title.dart';

class MainCardTitle extends StatelessWidget {
  final List imageUrl;
  const MainCardTitle({
    super.key,
    required this.title, required this.imageUrl,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitleWidget(title: title),
        kHeight,
        LimitedBox(
          maxHeight: 200,
          child:  ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrl.length,
            itemBuilder: (context, index) {
              return MainCard(imageUrl: imageUrl[index]);
            },
        )
     ), ],
    );
  }
}

class MainCardTitleData extends StatelessWidget {
  final List<Result> imageUrl;
  const MainCardTitleData({
    super.key,
    required this.title, required this.imageUrl,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitleWidget(title: title),
        kHeight,
        LimitedBox(
          maxHeight: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrl.length,
            itemBuilder: (context, index) {
              String img = "$baseImageUrl${imageUrl[index].posterPath}";
              return Container(
                width: 140,
                height: 200,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}