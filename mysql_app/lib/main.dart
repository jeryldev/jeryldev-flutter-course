import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mysql_app/article_list_view.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyArticleList());

class MyArticleList extends StatefulWidget {
  @override
  _MyArticleListState createState() => _MyArticleListState();
}

class _MyArticleListState extends State<MyArticleList> {
  Future<List> getData() async {
    // For emulator use 10.0.0.2
    // For real device connected to PC, use your computers real address
    // CMD > ipconfig
    String url = 'http://10.0.2.2/jeryllocalhost/get_data.php';
    final response =
        await http.get(url, headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    print(responseBody);
    return responseBody;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.error) print(snapshot.error);

          return snapshot.hasData
              ? ArticleListView(list: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
