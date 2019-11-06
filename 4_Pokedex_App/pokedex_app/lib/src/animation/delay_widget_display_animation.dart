import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pokedex_app/src/animation/custom_delay_display_animation.dart';

// This function increments and returns a Duration
// The delay is reset when no new animations have been added for a short moment
//  (you can change the conditions of this to match your requirements)
Timer _displayReset;
Duration _displayDelay = Duration();

_getDelay() {
  if (_displayReset == null || !_displayReset.isActive) {
    _displayReset = Timer(Duration(milliseconds: 300), () {
      _displayDelay = Duration();
    });
  }
  _displayDelay += Duration(milliseconds: 100);
  return _displayDelay;
}

class DelayWidgetDisplayAnimation extends StatelessWidget {
  final Widget child;

  const DelayWidgetDisplayAnimation({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDelayDisplayAnimation(
      delay: _getDelay(),
      child: child,
    );
  }
}
