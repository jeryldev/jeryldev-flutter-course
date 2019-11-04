import 'dart:async';

import 'package:flutter/material.dart';

class ShowUpAnimation extends StatefulWidget {
  final Widget child;

  ShowUpAnimation({@required this.child});

  @override
  _ShowUpAnimationState createState() => _ShowUpAnimationState();
}

class _ShowUpAnimationState extends State<ShowUpAnimation>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animationOffset;
  final int delay = 350;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    final curve = CurvedAnimation(
      curve: Curves.decelerate,
      parent: _animationController,
    );
    _animationOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (delay == null) {
      _animationController.forward();
    } else {
      Timer(Duration(milliseconds: delay), () {
        _animationController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animationOffset,
        child: widget.child,
      ),
      opacity: _animationController,
    );
  }
}
