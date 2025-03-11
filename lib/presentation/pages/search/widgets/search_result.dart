import 'package:flutter/material.dart';
import 'package:netflix_clone/core/strings.dart';

import '../../../../core/constants.dart';
import '../../../../domain/core/models/tile_card_model.dart';
import 'title.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key, required this.searchResults});
  final List<Result> searchResults;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTitle(
          title: "Movies & TV",
        ),
        kHeight,
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final movie = searchResults[index];
              return MainCardWidget(image: "$baseHorimage${movie.posterPath}");
            },
          ),
        ),
      ],
    );
  }
}

class MainCardWidget extends StatelessWidget {
  final String image;
  const MainCardWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          image: DecorationImage(image: NetworkImage(image))),
    );
  }
}
