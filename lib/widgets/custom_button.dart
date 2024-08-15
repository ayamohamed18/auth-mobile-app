import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class CustomButon extends StatelessWidget {
  CustomButon({super.key, this.onTap, required this.text, required this.color});
  VoidCallback? onTap;
  String text;
  Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: HexColor("#FFFFFF")),
          ),
        ),
      ),
    );
  }
}
