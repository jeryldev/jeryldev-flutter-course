import 'package:flutter/material.dart';
import './detail_data.dart';

class ItemList extends StatelessWidget {
  final List list;

  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
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
                  list[i]['item_name'], // column name in the table
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                leading: Icon(
                  Icons.shopping_cart,
                  size: 36,
                  color: Colors.blue,
                ),
                subtitle: Text("Stock : ${list[i]['stock']}"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        );
      },
    );
  }
}
