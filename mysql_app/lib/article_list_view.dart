import 'package:flutter/material.dart';
import 'package:mysql_app/article_detail.dart';
import 'package:mysql_app/create_article.dart';

class ArticleListView extends StatelessWidget {
  ArticleListView({this.list});

  final List list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 8.0,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => CreateArticle(),
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => Detail(
                  list: list,
                  index: index,
                ),
              ),
            ),
            child: Card(
              elevation: 8.0,
              child: ListTile(
                title: Text(
                  list[index]['title'], // column name in the table
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                leading: Image.network('https://source.unsplash.com/random'),
                subtitle: Text(
                  "${list[index]['description']}",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
