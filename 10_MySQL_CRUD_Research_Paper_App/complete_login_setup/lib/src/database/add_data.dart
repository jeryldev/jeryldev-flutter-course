import 'package:complete_login_setup/src/widgets/form_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerStock = TextEditingController();

  void addData() {
    String url = 'http://10.0.2.2/jeryllocalhost/add_data.php';

    http.post(url, body: {
      "item_code": controllerCode.text,
      "item_name": controllerName.text,
      "price": controllerPrice.text,
      "stock": controllerStock.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: controllerCode,
                  decoration: InputDecoration(
                    hintText: "Item Code",
                    labelText: "Item Code",
                  ),
                ),
                TextField(
                  controller: controllerName,
                  decoration: InputDecoration(
                      hintText: "Item Name", labelText: "Item Name"),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerPrice,
                  decoration:
                      InputDecoration(hintText: "Price", labelText: "Price"),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerStock,
                  decoration: InputDecoration(
                    hintText: "Stock",
                    labelText: "Stock",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: FormSubmitButton(
                    text: 'Add Data',
                    onPressed: () => setState(
                      () {
                        if (controllerPrice.text.isNotEmpty &&
                            controllerCode.text.isNotEmpty &&
                            controllerName.text.isNotEmpty &&
                            controllerStock.text.isNotEmpty) {
                          addData();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
