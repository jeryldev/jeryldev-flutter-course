import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  double calculatedNumber = 5.00;
  final numberInput = TextEditingController();
  var input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: numberInput,
                onSubmitted: (value) {
                  print(value);
                  setState(() {
                    input = numberInput.text;
                  });
                },
//                onChanged: (value) {
//                  setState(() {
//                    input = numberInput.text;
//                    print(numberInput.text);
//                    print(input);
//                  });
//                },
              ),
            ),
            Text(
              calculatedNumber.toStringAsFixed(2),
              style: TextStyle(fontSize: 36),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
//            calculatedNumber++;
//            double conv = input;
            print(' ${calculatedNumber * double.parse(input)}');
            setState(() {
              calculatedNumber = calculatedNumber * double.parse(input);
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
