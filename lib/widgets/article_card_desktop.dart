import 'package:flutter/material.dart';
import 'package:newsapp/constants/data.dart';

class ArticleCardDesktop extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String source;
  final String publishedAt;

  ArticleCardDesktop(
      {required this.imageUrl,
      required this.title,
      required this.source,
      required this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageUrl == null
                        ? const AssetImage(Data.PLACEHOLDER_IMAGE)
                        : NetworkImage(
                            imageUrl,
                          ),
                    fit: BoxFit.cover)),
          ),
          title: Text(source,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
          subtitle: Text(title),
          trailing: Text(publishedAt),
        ),
      ),
    );
  }
}
