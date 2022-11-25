import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final String city;
  final AssetImage img;
  const Categories({super.key, required this.city, required this.img});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Ink.image(
            image: img,
            height: 100,
            width: 200,
            fit: BoxFit.cover,
            // colorFilter: ColorFilers.greyscale,
          ),
          Text(
            city,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
          )
        ],
      ),
    );
  }
}
