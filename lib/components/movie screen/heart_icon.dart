import 'package:flutter/material.dart';

class HeartIcon extends StatelessWidget {
  const HeartIcon({
    required this.heartColor,
    Key? key,
  }) : super(key: key);
  final Color heartColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFF198FD8),
            Color(0xFFe0dede),
          ],
        ),
      ),
      child: Icon(
        Icons.favorite,
        color: heartColor,
        size: 40,
      ),
    );
  }
}
