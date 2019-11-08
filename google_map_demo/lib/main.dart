import 'package:flutter/material.dart';
import 'package:google_map_demo/src/widgets/map_view_widget.dart';
import 'package:google_map_demo/src/models/user_location_model.dart';
import 'package:google_map_demo/src/services/location_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserLocationModel>.value(
          value: LocationService().locationStream,
        ),
      ],
      child: MaterialApp(
        title: 'Google Maps Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MapView(title: 'Flutter Google Maps Demo'),
      ),
    );
  }
}
