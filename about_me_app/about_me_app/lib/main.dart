import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String paragraph;
  String title = 'Hello';

  @override
  void initState() {
    // TODO: implement initState
    paragraph =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Augue lacus viverra vitae congue. Eget nunc lobortis mattis aliquam faucibus. Phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor. Risus nec feugiat in fermentum posuere urna nec tincidunt. Velit scelerisque in dictum non consectetur a erat. Non blandit massa enim nec dui nunc mattis. Sit amet facilisis magna etiam tempor orci eu. Faucibus interdum posuere lorem ipsum dolor sit amet. Mattis pellentesque id nibh tortor id aliquet lectus proin. Dui nunc mattis enim ut tellus. Varius duis at consectetur lorem donec massa In tellus integer feugiat scelerisque. Enim praesent elementum facilisis leo. Lectus quam id leo in. Ullamcorper a lacus vestibulum sed arcu non odio euismod lacinia. Nec nam aliquam sem et tortor consequat id porta. Nibh tortor id aliquet lectus proin nibh nisl condimentum id. Tincidunt augue interdum velit euismod in pellentesque. Morbi non arcu risus quis. Adipiscing enim eu turpis egestas pretium. Lectus sit amet est placerat. Ligula ullamcorper malesuada proin libero. Nunc pulvinar sapien et ligula ullamcorper malesuada proin libero nunc';
    title = 'Jeryl';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.red,
        splashColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
            paragraph = 'Hello World!';
            title = 'PCHRD';
          }),
          child: Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hello World',
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
                Text(
                  paragraph,
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
