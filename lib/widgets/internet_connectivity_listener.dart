import 'dart:async';

import 'package:flutter/material.dart';

import '../internet_connectivity.dart';


typedef InternetAccessListener = Function(
    BuildContext context, bool hasInternetAccess);

// ignore: must_be_immutable
class InternetConnectivityListener extends StatefulWidget {
  InternetConnectivityListener({
    Key? key,
    required this.child,
    required this.connectivityListener,
    InternetConnectivity? internetConnectivity,
  }) : super(key: key) {
    _internetConnectivity = internetConnectivity ?? InternetConnectivity();
  }

  final Widget child;
  InternetConnectivity? _internetConnectivity;
  final InternetAccessListener connectivityListener;

  @override
  _InternetConnectivityListenerState createState() =>
      _InternetConnectivityListenerState();
}

class _InternetConnectivityListenerState
    extends State<InternetConnectivityListener> {
  InternetAccessListener? get onConnectivityChanged =>
      widget.connectivityListener;

  InternetConnectivity get internetConnectivity =>
      widget._internetConnectivity!;

  late StreamSubscription<bool> subscription;

  @override
  void initState() {
    super.initState();
    subscription =
        internetConnectivity.observeInternetAccess.listen((event) {
      onConnectivityChanged?.call(context, event);
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}