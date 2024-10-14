import 'package:flutter/material.dart';

class SourceCard extends StatelessWidget {
  final String sourceName;
  final String country;

  SourceCard({required this.sourceName, required this.country});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber[100],
      elevation: 5.0,
      margin: const EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              sourceName,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Country: $country",
              style: const TextStyle(fontSize: 15.0),
            ),
          )
        ],
      ),
    );
  }
}