import 'package:flutter/material.dart';
import 'package:netflix_clone/core/strings.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/constants.dart';
import '../../../../domain/core/models/tile_card_model.dart';
import '../../widgets/cutsom_button_widget.dart';

class EveryOnesWatchingWidget extends StatelessWidget {
  final Result movie;
  const EveryOnesWatchingWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    String imageUrl = "$baseImageUrl${movie.posterPath}";
    String title = movie.title ?? "No Title";
    String description = movie.overview?? "No description available";

    return Container(
      width: MediaQuery.of(context).size.width,
      //height: 470,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.4)),
      ),
      child: Column(
             mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          kHeight,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                kHeight,
                Text(description, style: const TextStyle(color: Colors.white70)),
                kHeight,
                Row(
                  children: [
                    const CustomButtonWidget(
                      buttonTitle: "Play",
                      icon: Icons.play_arrow,
                      labelColor: kBlackColor,
                      backgroundColor: kWhiteColor,
                    ),
                    kWidth20,
                     CustomButtonWidget(
                      buttonTitle: "My List",
                      icon: Icons.add,
                      labelColor: kWhiteColor,
                      backgroundColor: Colors.grey.withOpacity(0.4),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}