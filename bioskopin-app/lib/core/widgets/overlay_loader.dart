// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

class OverlayLoader extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const OverlayLoader({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return OverlayLoaderWithAppIcon(
      isLoading: isLoading,
      appIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/logo.png'),
      ),
      circularProgressColor: const Color(0xFF277FBF),
      overlayBackgroundColor: Colors.black,
      child: child,
    );
  }
}
