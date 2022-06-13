import 'package:flutter/material.dart';

/**
 *    renvoie une box avec un taille fixe, et fond définit par le paramètre color
 *  et l'icon en paramètre
 */

class CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const CircularIcon({Key? key, required this.icon, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16.0,
      ),
    );
  }
}
