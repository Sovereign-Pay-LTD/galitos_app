import 'package:flutter/material.dart';

import '../constant.dart';
import '../utils/screen_size.dart';

class Btn extends StatelessWidget {
  final Color btn;
  final String btnText;

  const Btn({
    super.key,
    required this.btn,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: Displaylandscape
          ? ScreenSize().getScreenHeight(6)
          : ScreenSize().getScreenHeight(3),
      width: Displaylandscape
          ? ScreenSize().getScreenWidth(18)
          : ScreenSize().getScreenWidth(22),
      decoration: BoxDecoration(
          color: btn,
          border: Border.all(width: 1, color: Colors.transparent),
          borderRadius:
              BorderRadius.circular(ScreenSize().getScreenHeight(0.3))),
      child: Center(
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: Displaylandscape
                  ? ScreenSize().getScreenHeight(2.3)
                  : ScreenSize().getScreenHeight(0.8),
              color: Colors.white,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class ConfigBtn extends StatelessWidget {
  final Color btn;
  final String btnText;

  const ConfigBtn({
    super.key,
    required this.btn,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: Displaylandscape
          ? ScreenSize().getScreenHeight(6)
          : ScreenSize().getScreenHeight(3),
      width: Displaylandscape
          ? ScreenSize().getScreenWidth(12)
          : ScreenSize().getScreenWidth(15),
      decoration: BoxDecoration(
          color: btn,
          border: Border.all(width: 1, color: Colors.transparent),
          borderRadius:
              BorderRadius.circular(ScreenSize().getScreenHeight(0.3))),
      child: Center(
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: Displaylandscape
                  ? ScreenSize().getScreenHeight(2.3)
                  : ScreenSize().getScreenHeight(0.8),
              color: Colors.white,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

Widget sidebarBtn(String btnText) {
  return Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    height: Displaylandscape
        ? ScreenSize().getScreenHeight(6)
        : ScreenSize().getScreenHeight(4),
    width: ScreenSize().getScreenWidth(25),
    decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1, color: Colors.black45),
        borderRadius: BorderRadius.circular(ScreenSize().getScreenHeight(0.5))),
    child: Center(
      child: Text(
        btnText,
        style: TextStyle(
            fontSize: Displaylandscape
                ? ScreenSize().getScreenHeight(1.8)
                : ScreenSize().getScreenHeight(1.3),
            color: Colors.black,
            fontWeight: FontWeight.w500),
      ),
    ),
  );
}

// 