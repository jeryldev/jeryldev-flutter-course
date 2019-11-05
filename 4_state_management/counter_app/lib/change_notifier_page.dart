import 'package:counter_app/change_notifier_bloc.dart';
import 'package:counter_app/counter_bloc.dart';
import 'package:counter_app/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeNotifierPage extends StatefulWidget {
  @override
  _ChangeNotifierPageState createState() => _ChangeNotifierPageState();
}

class _ChangeNotifierPageState extends State<ChangeNotifierPage> {
  double number = 0;

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<ChangeNotifierBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _bloc.counter.toString(),
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            SizedBox(height: 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                customButton(
                  func: () => _bloc.increment(),
                  icon: Icons.add,
                ),
                SizedBox(width: 16),
                customButton(
                  icon: Icons.remove,
                  func: () => _bloc.decrement(),
                )
//                FloatingActionButton(
//                  onPressed: () => _bloc.decrement(),
//                  child: Icon(Icons.remove),
//                  backgroundColor: Colors.green,
//                  shape: RoundedRectangleBorder(),
//                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
