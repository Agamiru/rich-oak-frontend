import 'package:flutter/material.dart';


class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width <= 1200;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isCustom(
      BuildContext context, int customWidth, OperatorValue optVal
      ) {
    switch (optVal) {
      case OperatorValue.gt:
        return MediaQuery.of(context).size.width > customWidth;
      case OperatorValue.lt:
        return MediaQuery.of(context).size.width < customWidth;
      case OperatorValue.gte:
        return MediaQuery.of(context).size.width >= customWidth;
      case OperatorValue.lte:
        return MediaQuery.of(context).size.width <= customWidth;
      case OperatorValue.eq:
        return MediaQuery.of(context).size.width == customWidth;
      default:
        return false;
    }

    return MediaQuery.of(context).size.width < customWidth;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1200) {
          return largeScreen;
        } else if (constraints.maxWidth <= 1200 &&
            constraints.maxWidth >= 800) {
          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}


enum OperatorValue {
  gt, lt, gte, lte, eq
}