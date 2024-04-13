import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}

/// loading style, default [EasyLoadingStyle.dark].
EasyLoadingStyle loadingStyle = EasyLoadingStyle.dark;

/// loading indicator type, default [EasyLoadingIndicatorType.fadingCircle].
EasyLoadingIndicatorType indicatorType = EasyLoadingIndicatorType.fadingCircle;

/// loading mask type, default [EasyLoadingMaskType.none].
EasyLoadingMaskType maskType = EasyLoadingMaskType.none;

/// toast position, default [EasyLoadingToastPosition.center].
EasyLoadingToastPosition toastPosition = EasyLoadingToastPosition.center;

/// loading animationStyle, default [EasyLoadingAnimationStyle.opacity].
EasyLoadingAnimationStyle animationStyle = EasyLoadingAnimationStyle.opacity;

/// loading custom animation, default null.
EasyLoadingAnimation customAnimation = CustomAnimation();

/// textAlign of status, default [TextAlign.center].
TextAlign textAlign = TextAlign.center;

/// textStyle of status, default null.
TextStyle? textStyle;

/// content padding of loading.
EdgeInsets contentPadding = EdgeInsets.zero;

/// padding of [status].
EdgeInsets textPadding = EdgeInsets.zero;

/// size of indicator, default 40.0.
double indicatorSize = 40.0;

/// radius of loading, default 5.0.
double radius = 5.0;

/// fontSize of loading, default 15.0.
double fontSize = 15.0;

/// width of progress indicator, default 2.0.
double progressWidth = 2.0;

/// width of indicator, default 4.0, only used for [EasyLoadingIndicatorType.ring, EasyLoadingIndicatorType.dualRing].
double lineWidth = 4.0;

/// display duration of [showSuccess] [showError] [showInfo], default 2000ms.
Duration displayDuration = Duration(milliseconds: 2000);

/// animation duration of indicator, default 200ms.
Duration animationDuration = Duration(milliseconds: 200);

/// color of loading status, only used for [EasyLoadingStyle.custom].
Color? textColor;

/// color of loading indicator, only used for [EasyLoadingStyle.custom].
Color? indicatorColor;

/// progress color of loading, only used for [EasyLoadingStyle.custom].
Color? progressColor;

/// background color of loading, only used for [EasyLoadingStyle.custom].
Color? backgroundColor;

/// mask color of loading, only used for [EasyLoadingMaskType.custom].
Color? maskColor;

/// should allow user interactions while loading is displayed.
bool userInteractions = true;

/// should dismiss on user tap.
bool dismissOnTap = false;

/// indicator widget of loading
Widget? indicatorWidget;

/// success widget of loading
Widget? successWidget;

/// error widget of loading
Widget? errorWidget;

/// info widget of loading
Widget? infoWidget;
