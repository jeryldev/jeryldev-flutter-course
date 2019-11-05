import 'package:counter_app/change_notifier_bloc.dart';
import 'package:counter_app/change_notifier_page.dart';
import 'package:counter_app/counter_bloc.dart';
import 'package:counter_app/home_page.dart';
import 'package:counter_app/home_provider_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeNotifierBloc>(
      builder: (_) => ChangeNotifierBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
//        home: MyHomePage(),
//        home: ProviderPage(),
        home: ChangeNotifierPage(),
      ),
    );
  }
}
