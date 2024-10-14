import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final image;
  final categoryName;

  CategoryTile({@required this.image, @required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 150,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover)),
          ),
          Positioned(
              right: 2,
              bottom: 10,
              child: Container(
                decoration: BoxDecoration(color: Colors.black54),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                  child: Text(
                    "$categoryName".toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}