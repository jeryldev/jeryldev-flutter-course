import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:researcher_app/src/pages/home_page.dart';
import 'package:researcher_app/src/widgets/form_submit_button.dart';
import 'update_article.dart';

class Detail extends StatefulWidget {
  List list;
  int index;

  Detail({this.index, this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
// delete start

  void deleteData() {
    String url = 'http://10.0.2.2/jeryllocalhost/delete_data.php';
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "Are You sure want to delete '${widget.list[widget.index]['title']}'"),
      actions: <Widget>[
        FormSubmitButton(
          text: "Delete",
          onPressed: () {
            deleteData();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(),
              ),
            );
          },
        ),
        FormSubmitButton(
          text: "Cancel",
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Article Detail",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "${widget.list[widget.index]['title']}",
                // column name in the table
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Text(
                "by: ${widget.list[widget.index]['author']}",
                // column name in the table
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 24),
              Text(
                widget.list[widget.index]
                    ['description'], // column name in the table
                style: TextStyle(fontSize: 25.0), textAlign: TextAlign.justify,
              ),
              SizedBox(height: 24),
              FlatButton(
                onPressed: () =>
                    print('run the function to download the article File'),
                child: Text(
                  "Download Link: ${widget.list[widget.index]['downloadURL']}",
                  // column name in the table
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FormSubmitButton(
                    text: 'Edit',
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => EditData(
                          list: widget.list,
                          index: widget.index,
                        ),
                      ),
                    ),
                  ),
                  FormSubmitButton(
                    text: "Delete",
                    onPressed: () => confirm(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
