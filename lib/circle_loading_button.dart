import 'package:flutter/material.dart';

/// Simply download this file and use it by importing in your flutter application

class LoadingCircleButton extends StatefulWidget {
    final Function callback;
    final Color buttonColor;
    final double minRadius;
    final double maxRadius;
    final Duration animationDuration;
    final Widget restChild;
    final Widget loadingChild;
    const LoadingCircleButton({Key key,@required this.callback,@required this.buttonColor,@required this.minRadius,@required this.maxRadius, this.animationDuration = const Duration(milliseconds: 800), this.restChild = const Text("Start"), this.loadingChild = const Text("Loading...")}) : super(key: key);
    @override
    _LoadingCircleButtonState createState() => _LoadingCircleButtonState();
}

class _LoadingCircleButtonState extends State<LoadingCircleButton> {
    double circleOneSize, circleTwoSize, circleThreeSize;
    bool animationRunning = false;
    Color coverColor;

    Future<bool> startAnimation() async {
        animationRunning = true;
        while (animationRunning) {
            setState(() {
                circleOneSize = widget.maxRadius;
                circleTwoSize = widget.maxRadius * 0.8;
                circleThreeSize = widget.maxRadius * 0.65;
            });
            await Future.delayed(widget.animationDuration);
            setState(() {
                circleOneSize = circleTwoSize = circleThreeSize = widget.minRadius;
            });
            await Future.delayed(widget.animationDuration);
        }
        return true;
    }

    bool stopAnimation() {
        setState(() {
            animationRunning = false;
        });
        return true;
    }

    @override
    void initState() {
        super.initState();
        coverColor = widget.buttonColor.withAlpha(50);
        circleOneSize = circleTwoSize = circleThreeSize = widget.minRadius;
    }

    @override
    Widget build(BuildContext context) {
        return Stack(
            alignment: Alignment.center,
            children: <Widget>[
                AnimatedContainer(
                    duration: widget.animationDuration,
                    height: circleOneSize,
                    width: circleOneSize,
                    curve: Curves.easeInOut,
                    decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: coverColor,
                    ),
                ),
                AnimatedContainer(
                    duration: widget.animationDuration,
                    height: circleTwoSize,
                    width: circleTwoSize,
                    curve: Curves.easeInOut,
                    decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: coverColor,
                    ),
                ),
                AnimatedContainer(
                    duration: widget.animationDuration,
                    height: circleThreeSize,
                    width: circleThreeSize,
                    curve: Curves.easeInOut,
                    decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: coverColor,
                    ),
                ),
                SizedBox(
                    height: widget.minRadius,
                    width: widget.minRadius,
                    child: RaisedButton(
                        onPressed: () async {
                            startAnimation();
                            await widget.callback();
                            stopAnimation();
                        },
                        color: widget.buttonColor,
                        shape: CircleBorder(),
                        child: animationRunning ? widget.loadingChild : widget.restChild,
                    ),
                ),
            ],
        );
    }
}
