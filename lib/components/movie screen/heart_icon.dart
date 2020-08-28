import 'package:flutter/material.dart';

class HeartIcon extends StatelessWidget {
  const HeartIcon({
    Key key,
    this.heartColor,
  }) : super(key: key);
  final Color heartColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF198FD8),
            Color(0xFFe0dede),
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.blue.withOpacity(0.3),
        ),
        child: Icon(
          Icons.favorite,
          color: heartColor,
          size: 60,
        ),
      ),
    );
  }
}
