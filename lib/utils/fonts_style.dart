
import 'package:flutter/material.dart';
import 'package:myshop_app/res/app_colors.dart';
import 'package:myshop_app/utils/screen_size.dart';

import '../constant.dart';

class FontsStyle {
  tabletitle() {
    return TextStyle(
        color: Colors.black54,
        fontSize: Displaylandscape
            ? ScreenSize().getScreenHeight(3)
            : ScreenSize().getScreenHeight(1.3),
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w600);
  }

  title() {
    return TextStyle(
        color: Colors.black,
        fontSize: Displaylandscape
            ? ScreenSize().getScreenHeight(3)
            : ScreenSize().getScreenHeight(1.3),
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w600);
  }

  tabledata() {
    return TextStyle(
        color: Colors.black87,
        fontSize: Displaylandscape
            ? ScreenSize().getScreenHeight(3)
            : ScreenSize().getScreenHeight(1.3),
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w400);
  }

  drawerText() {
    return TextStyle(
        color: Colors.white,
        fontSize: Displaylandscape
            ? ScreenSize().getScreenHeight(3)
            : ScreenSize().getScreenHeight(1),
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w400);
  }

  functionText() {
    return TextStyle(
        fontSize: Displaylandscape
            ? ScreenSize().getScreenHeight(2)
            : ScreenSize().getScreenHeight(1),
        color: AppColors.primary,
        fontWeight: FontWeight.w400);
  }

  blackText() {
    return TextStyle(
        fontSize: Displaylandscape
            ? ScreenSize().getScreenHeight(2)
            : ScreenSize().getScreenHeight(1),
        color: Colors.black,
        fontWeight: FontWeight.w600);
  }

  subtiletext() {
    return TextStyle(
        fontSize: Displaylandscape
            ? ScreenSize().getScreenHeight(2)
            : ScreenSize().getScreenHeight(1),
        color: Colors.black38,
        fontWeight: FontWeight.w400);
  }

  modalTitle() {
    return TextStyle(
        fontSize: Displaylandscape
            ? ScreenSize().getScreenHeight(1.5)
            : ScreenSize().getScreenHeight(1),
        color: Colors.black,
        fontWeight: FontWeight.w600);
  }

  failedModalTitle() {
    return TextStyle(
        fontSize: Displaylandscape
            ? ScreenSize().getScreenHeight(1.5)
            : ScreenSize().getScreenHeight(1),
        color: Colors.black,
        fontWeight: FontWeight.w600);
  }
}
