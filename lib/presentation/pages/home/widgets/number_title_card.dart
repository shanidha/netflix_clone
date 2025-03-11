import 'package:flutter/material.dart';
import 'package:netflix_clone/core/strings.dart';
import 'package:netflix_clone/presentation/pages/home/widgets/number_card.dart';
import '../../../../core/constants.dart';
import '../../../../domain/core/models/tile_card_model.dart';
import '../../widgets/main_title.dart';

class NumberTitleCard extends StatelessWidget {
  final List<Result> tvShows;
  const NumberTitleCard({super.key, required this.tvShows});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitleWidget(title: "Top 10 TV Shows in India"),
        kHeight,
        LimitedBox(
          maxHeight: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tvShows.length,
            itemBuilder: (context, index) {
              String img = "$baseImageUrl${tvShows[index].posterPath}";
              return NumberCardWidget(index: index,url: img,);
            },
          ),
        ),
      ],
    );
  }
}