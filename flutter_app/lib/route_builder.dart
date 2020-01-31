import 'package:flutter/material.dart';

class BaseRouteBuilder extends PageRouteBuilder {
  final Widget page;

  BaseRouteBuilder(
      {@required this.page,
      @required RouteTransitionsBuilder transitionsBuilder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: transitionsBuilder,
        );
}

class SlideRouteBuilder extends BaseRouteBuilder {
  SlideRouteBuilder(Widget page)
      : super(
          page: page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            child: child,
            position: Tween<Offset>(
              begin: Offset(-1, -1),
              end: Offset.zero,
            ).animate(animation),
          ),
        );
}

class ScaleRouteBuilder extends BaseRouteBuilder {
  ScaleRouteBuilder(Widget page)
      : super(
          page: page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              ScaleTransition(
            child: child,
            scale: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            )),
          ),
        );
}

class RotationRouteBuilder extends BaseRouteBuilder {
  RotationRouteBuilder(Widget page)
      : super(
          page: page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              RotationTransition(
            child: child,
            turns: CurvedAnimation(parent: animation, curve: Curves.linear),
          ),
        );
}

class SizeRouteBuilder extends BaseRouteBuilder {
  SizeRouteBuilder(Widget page)
      : super(
          page: page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          ),
        );
}

class FadeRouteBuilder extends BaseRouteBuilder {
  FadeRouteBuilder(Widget page)
      : super(
          page: page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

class EnterExitRouteBuilder extends BaseRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;

  EnterExitRouteBuilder({this.enterPage, this.exitPage})
      : super(
          page: enterPage,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(-1.0, 0.0),
                ).animate(animation),
                child: exitPage,
              ),
              SlideTransition(
                position:
                    Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
                        .animate(animation),
                child: enterPage,
              ),
            ],
          ),
        );
}

class ScaleRotateRouteBuilder extends BaseRouteBuilder {
  ScaleRotateRouteBuilder(Widget page)
      : super(
          page: page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: RotationTransition(
              turns: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.linear,
                ),
              ),
              child: child,
            ),
          ),
        );
}
