import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:researcher_app/src/pages/home_page.dart';
import 'package:researcher_app/src/widgets/form_submit_button.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list, this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController controllerTitle;
  TextEditingController controllerDescription;
  TextEditingController controllerAuthor;
  TextEditingController controllerDownloadURL;

  void editData() {
    String url = 'http://10.0.2.2/jeryllocalhost/edit_data.php';
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "title": controllerTitle.text,
      "description": controllerDescription.text,
      "downloadURL": controllerDownloadURL.text,
      "author": controllerAuthor.text
    });
  }

  @override
  void initState() {
    controllerTitle =
        TextEditingController(text: widget.list[widget.index]['title']);
    controllerDescription =
        TextEditingController(text: widget.list[widget.index]['description']);
    controllerDownloadURL =
        TextEditingController(text: widget.list[widget.index]['downloadURL']);
    controllerAuthor =
        TextEditingController(text: widget.list[widget.index]['author']);
    super.initState();
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
                text: 'Update',
                onPressed: () {
                  editData();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
