import 'package:complete_login_setup/src/pages/home_page.dart';
import 'package:complete_login_setup/src/widgets/form_submit_button.dart';
import 'package:complete_login_setup/src/widgets/platform_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './edit_data.dart';

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
          "Are You sure want to delete '${widget.list[widget.index]['item_name']}'"),
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
          title: Text(
        "${widget.list[widget.index]['item_name']}",
        // column name in the table
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      )),
      body: Center(
        child: Container(
          height: 350.0,
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 8.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.list[widget.index]
                      ['item_name'], // column name in the table
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(height: 25),
                Text(
                  "Code : ${widget.list[widget.index]['item_code']}",
                  // column name in the table
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  "Price : ${widget.list[widget.index]['price']}",
                  // column name in the table
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  "Stock : ${widget.list[widget.index]['stock']}",
                  // column name in the table
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FormSubmitButton(
                      text: 'Edit',
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => EditData(
                          list: widget.list,
                          index: widget.index,
                        ),
                      )),
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
      ),
    );
  }
}
