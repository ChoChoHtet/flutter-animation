import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animation/animation/explicit_animation.dart';

const kAnimationDuration = Duration(milliseconds: 500);
const kAnimationFadeIn = Duration(milliseconds: 1000);

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({Key? key}) : super(key: key);

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  bool isNewDimension = false;
  bool isShowDescription = false;
  bool isChangeTheme = false;
  bool isChangeLayout = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TweenAnimationBuilder(
            duration: kAnimationFadeIn,
            tween: Tween<double>(begin: 0, end: 1),
            child: AnimatedContainer(
              duration: kAnimationDuration,
              color: (isChangeTheme)
                  ? Colors.black
                  : Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        AnimatedContainer(
                          width: (isNewDimension) ? 350 : 250,
                          height: (isNewDimension) ? 300 : 200,
                          duration: kAnimationDuration,
                          curve: Curves.easeInCubic,
                          child: Image.asset("assets/graduate.png"),
                        ),
                        const Positioned(
                          top: 0,
                          right: 0,
                          child: ExplicitAnimation(),
                        ),
                      ],
                    ),
                    AnimatedSize(
                      duration: kAnimationDuration,
                      child: Container(
                        height: (isShowDescription) ? null : 0,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "View binding is a feature that allows you to more easily write code that interacts with views. Once view binding is enabled in a module, it generates a binding class for each XML layout file present in that module. An instance of a binding class contains direct references to all views that have an ID in the corresponding layout.",
                              style: TextStyle(
                                color: (isChangeTheme)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedSize(
                      duration: kAnimationDuration,
                      child: AnimatedSwitcher(
                        duration: kAnimationDuration,
                        child: (isChangeLayout)
                            ? ButtonWrapView(
                                isDescShow: isShowDescription,
                                onTapDimension: () {
                                  setState(() {
                                    isNewDimension = !isNewDimension;
                                  });
                                },
                                onTapDescription: () {
                                  setState(() {
                                    isShowDescription = !isShowDescription;
                                  });
                                },
                                onTapChangeTheme: () {
                                  setState(() {
                                    isChangeTheme = !isChangeTheme;
                                  });
                                },
                              )
                            : ButtonColumnView(
                                isDescShow: isShowDescription,
                                onTapDimension: () {
                                  setState(() {
                                    isNewDimension = !isNewDimension;
                                  });
                                },
                                onTapDescription: () {
                                  setState(() {
                                    isShowDescription = !isShowDescription;
                                  });
                                },
                                onTapChangeTheme: () {
                                  setState(() {
                                    isChangeTheme = !isChangeTheme;
                                  });
                                },
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red //background
                          ),
                      onPressed: () {
                        setState(() {
                          isChangeLayout = !isChangeLayout;
                        });
                      },
                      child: const Text("Change Button Layout"),
                    )
                  ],
                ),
              ),
            ),
            builder: (context, double opacityValue, child) => Opacity(
              opacity: opacityValue,
              child: child,
            ),
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: kAnimationFadeIn,
            builder: (context, double value, child) => Opacity(
              opacity: value,
              child: Padding(
                padding: EdgeInsets.only(
                  top: value * 64,
                  left: 16,
                ),
                child: child,
              ),
            ),
            child: const Text(
              "Hello Animation Test",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class ButtonColumnView extends StatelessWidget {
  const ButtonColumnView({
    Key? key,
    required this.isDescShow,
    required this.onTapDimension,
    required this.onTapDescription,
    required this.onTapChangeTheme,
  }) : super(key: key);
  final bool isDescShow;
  final VoidCallback onTapDimension;
  final VoidCallback onTapDescription;
  final VoidCallback onTapChangeTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onTapDimension,
          child: const Text("Change Dimension"),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: onTapDescription,
          child: Text((isDescShow) ? "Hide Description" : "Show Description"),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: onTapChangeTheme,
          child: const Text("Change Theme"),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ButtonWrapView extends StatelessWidget {
  const ButtonWrapView({
    Key? key,
    required this.isDescShow,
    required this.onTapDimension,
    required this.onTapDescription,
    required this.onTapChangeTheme,
  }) : super(key: key);
  final bool isDescShow;
  final VoidCallback onTapDimension;
  final VoidCallback onTapDescription;
  final VoidCallback onTapChangeTheme;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ElevatedButton(
          onPressed: onTapDimension,
          child: const Text("Change Dimension"),
        ),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: onTapDescription,
          child: Text((isDescShow) ? "Hide Description" : "Show Description"),
        ),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: onTapChangeTheme,
          child: const Text("Change Theme"),
        ),
      ],
    );
  }
}
