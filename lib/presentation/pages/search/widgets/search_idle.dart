import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/core/strings.dart';
import 'package:netflix_clone/domain/core/models/tile_card_model.dart';

import 'search_card.dart';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget(
      {super.key, required this.idleMovies, required this.idleNameMovies});
  final List<Result> idleMovies;
  final List<Result> idleNameMovies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recommended Mobile Games",
          style: TextStyle(
              fontSize: 18, color: kWhiteColor, fontWeight: FontWeight.bold),
        ),
        kHeight,
        LimitedBox(
            maxHeight: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: idleMovies.length,
              itemBuilder: (context, index) {
                final movie = idleMovies[index];
                return SearchCard(
                    action: "${movie.mediaType}",
                    name: "${movie.title}",
                    imageUrl: "$baseImageUrl${movie.posterPath}");
              },
            )),
        const Text(
          "Recommended Tv Shows & Mobiles",
          style: TextStyle(
              fontSize: 18, color: kWhiteColor, fontWeight: FontWeight.bold),
        ),
        kHeight,
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: idleNameMovies.length,
            itemBuilder: (context, index) {
              final movie = idleNameMovies[index];
              return TopSearchItemTile(
                url: "$baseImageUrl${movie.posterPath}",
                movieName: "${movie.title}",
              );
            },
            separatorBuilder: (context, index) => kHeight20,
          ),
        ),
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  const TopSearchItemTile(
      {super.key, required this.movieName, required this.url});
  final String movieName;
  final String url;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          height: 65,
          width: screenWidth * 0.35,
          decoration: BoxDecoration(
              image:
                  DecorationImage(fit: BoxFit.cover, image: NetworkImage(url))),
        ),
        kWidth,
        Expanded(
            child: Text(
          movieName,
          style: const TextStyle(color: kWhiteColor, fontSize: 16),
        )),
        const CircleAvatar(
          backgroundColor: kWhiteColor, radius: 25, //27,
          child: CircleAvatar(
              radius: 23, //25
              backgroundColor: kBlackColor,
              child: Icon(CupertinoIcons.play_fill, color: kWhiteColor)),
        ),
      ],
    );
  }
}
