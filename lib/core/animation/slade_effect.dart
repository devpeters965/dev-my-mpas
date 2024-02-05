import 'dart:async';
import 'package:flutter/material.dart';

class SladeAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  const SladeAnimation({super.key, required this.child, required this.delay});

  @override
  State<SladeAnimation> createState() => _FonctionAnimationState();
}

class _FonctionAnimationState extends State<SladeAnimation>
    // with TickerProviderStateMixin  {
      with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _animeOffset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // initilisation of deflaut controller

    _controller = AnimationController( vsync: this, duration: const Duration(milliseconds: 1500));

    // effet to decelerate of animationb
    final curve =
        CurvedAnimation(parent: _controller, curve: Curves.decelerate);

    // builde animation
    _animeOffset = Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero).animate(curve);

    // controller le temps daparution du widegt
    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animeOffset,
        child: widget.child,
      ),
    );
  }
}
