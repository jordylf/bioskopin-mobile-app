// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:skeletonizer/skeletonizer.dart';

class CustomSkeleton extends StatelessWidget {
  final bool? enabled;
  final bool? enableSwitchAnimation;
  final Color? containersColor;
  final Widget child;

  const CustomSkeleton({
    super.key,
    this.enabled,
    this.enableSwitchAnimation,
    this.containersColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled ?? true,
      enableSwitchAnimation: enableSwitchAnimation ?? true,
      containersColor: containersColor ?? Colors.grey.shade300,
      child: child,
    );
  }
}
