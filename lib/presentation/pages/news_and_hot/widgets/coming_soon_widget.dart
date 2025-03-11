import 'package:flutter/material.dart';
import 'package:netflix_clone/core/strings.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/constants.dart';
import '../../../../domain/core/models/tile_card_model.dart';
import '../../widgets/cutsom_button_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final Result movie;
  const ComingSoonWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    String imageUrl = "$baseImageUrl${movie.posterPath}";
    String title = movie.title ?? "No Title";
    String description = movie.overview ?? "No description available";
    String releaseDate = movie.releaseDate != null
        ? "${movie.releaseDate!.day.toString().padLeft(2, '0')} "
            "${_getMonthName(movie.releaseDate!.month)}, "
            "${movie.releaseDate!.year}"
        : "Coming Soon";

    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 550,
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
                Text(title,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                Text("Coming on $releaseDate",
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold)),
                kHeight,
                Text(description,
                    style: const TextStyle(color: Colors.white70)),
                kHeight,
                const CustomButtonWidget(
                  buttonTitle: "Remind Me",
                  icon: Icons.notifications_outlined,
                  labelColor: kBlackColor,
                  backgroundColor: kWhiteColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// **Helper Function to Convert Month Number to Name**
  String _getMonthName(int month) {
    const monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return monthNames[month - 1];
  }
}
