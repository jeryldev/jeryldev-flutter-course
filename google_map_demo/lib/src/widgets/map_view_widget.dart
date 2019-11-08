import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_map_demo/src/models/user_location_model.dart';
import 'package:google_map_demo/src/widgets/common/custom_floating_action_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  const MapView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _mapController = Completer();

  LatLng _fromLatLng;
  final Set<Marker> _markers = {};
  LatLng _currentMapPosition;
  MapType _currentMapType = MapType.normal;

  Widget build(BuildContext context) {
    UserLocationModel userLocation = Provider.of<UserLocationModel>(context);
    _fromLatLng = LatLng(userLocation.latitude, userLocation.longitude);
    _currentMapPosition = _fromLatLng;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _mapBuilder(context),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    _currentMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() {
    UserLocationModel userLocation = Provider.of<UserLocationModel>(context);
    setState(
      () {
        _markers.add(
          Marker(
            markerId: MarkerId(_currentMapPosition.toString()),
            position: _currentMapPosition,
            infoWindow: InfoWindow(
              title: 'These are the Coordinates',
              snippet:
                  'Latitude: ${userLocation?.latitude},Longitude: ${userLocation?.longitude}',
            ),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      },
    );
  }

  _onRemoveMarkerButtonPressed() {
    _markers.clear();
  }

  Widget _mapBuilder(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
//          tiltGesturesEnabled: true,
          initialCameraPosition:
              CameraPosition(target: _fromLatLng, zoom: 15, tilt: 65),
          onMapCreated: _onMapCreated,
          mapType: _currentMapType,
          markers: _markers,
          myLocationEnabled: true,
          onCameraMove: _onCameraMove,
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                customFloatingActionButton(_onMapTypeButtonPressed, Icons.map),
                SizedBox(height: 16.0),
                customFloatingActionButton(
                    _onAddMarkerButtonPressed, Icons.add_location),
                SizedBox(height: 16.0),
                customFloatingActionButton(
                    _onRemoveMarkerButtonPressed, Icons.clear),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
