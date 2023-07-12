import 'package:flutter/material.dart';

class ScreenUtil {
  ScreenUtil._();
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(BuildContext context, double percent) {
    return width(context) * percent;
  }

  static double getHeight(BuildContext context, double percent) {
    return height(context) * percent;
  }

  static Widget verticalSpace({double height = 12}) {
    return SizedBox(height: height);
  }

  static Widget horizontalSpace({double width = 12}) {
    return SizedBox(width: width);
  }
}
