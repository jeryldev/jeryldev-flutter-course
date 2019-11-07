import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:researcher_app/src/widgets/form_submit_button.dart';

class CreateArticle extends StatefulWidget {
  @override
  _CreateArticleState createState() => _CreateArticleState();
}

class _CreateArticleState extends State<CreateArticle> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerAuthor = TextEditingController();
  TextEditingController controllerDownloadURL = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void addData() {
    String url = 'http://10.0.2.2/jeryllocalhost/add_data.php';

    http.post(url, body: {
      "title": controllerTitle.text,
      "description": controllerDescription.text,
      "downloadURL": 'test',
      "author": controllerAuthor.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Publish Article"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: controllerTitle,
                decoration: InputDecoration(
                  hintText: "Title",
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.done,
              ),
              TextField(
                controller: controllerAuthor,
                decoration: InputDecoration(
                  hintText: "Author",
                  labelText: "Author",
                ),
                textInputAction: TextInputAction.done,
              ),
              TextField(
                controller: controllerDownloadURL,
                decoration: InputDecoration(
                  hintText: "Download Link",
                  labelText: "Download Link",
                ),
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 32),
              TextFormField(
                controller: controllerDescription,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLength: 1000,
                maxLines: 15,
                textInputAction: TextInputAction.done,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              FormSubmitButton(
                text: 'Publish',
                onPressed: () => setState(
                  () {
                    if (controllerAuthor.text.isNotEmpty &&
                        controllerTitle.text.isNotEmpty &&
                        controllerDescription.text.isNotEmpty) {
                      addData();
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
