import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:researcher_app/src/pages/article/article_detail.dart';

class ArticleList extends StatelessWidget {
  final List list;

  ArticleList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => Detail(
                list: list,
                index: i,
              ),
            ),
          ),
          child: Card(
            elevation: 8.0,
            child: ListTile(
              title: Text(
                list[i]['title'], // column name in the table
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              subtitle: Text(
                "${list[i]['description']}",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
}
