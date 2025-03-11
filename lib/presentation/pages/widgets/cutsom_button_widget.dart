import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String buttonTitle;
  final IconData icon;
  final Color backgroundColor;
  final Color labelColor;
  const CustomButtonWidget({
    super.key,
    required this.buttonTitle,
    required this.icon,
    required this.backgroundColor,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Colors.black),
          ),
          backgroundColor: backgroundColor),
      onPressed: () {},
      icon: Icon(icon,
          size: 30, //Icons.all_ou_sharp
          color: labelColor),
      label: Text(buttonTitle,
          style: TextStyle(
              color: labelColor, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
