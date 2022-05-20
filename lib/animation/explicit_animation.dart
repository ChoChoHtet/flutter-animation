import 'package:flutter/material.dart';

const kAnimationFav = Duration(seconds: 1);

class ExplicitAnimation extends StatefulWidget {
  const ExplicitAnimation({Key? key}) : super(key: key);

  @override
  State<ExplicitAnimation> createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation>
    with TickerProviderStateMixin {
  bool isAnimationComplete = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: kAnimationFav, vsync: this);
    _colorAnimation = ColorTween(begin: Colors.grey[500], end: Colors.red)
        .animate(_controller.view);

    _sizeAnimation =
        Tween<double>(begin: 30, end: 40).animate(_controller.view);

    _controller.addStatusListener((status) {
      isAnimationComplete = (AnimationStatus.completed == status);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, _) => IconButton(
        onPressed: () {
          if (isAnimationComplete) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        icon: Icon(
          Icons.favorite,
          size: _sizeAnimation.value,
          color: _colorAnimation.value,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
