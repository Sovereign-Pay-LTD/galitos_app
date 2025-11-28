import 'package:flutter/material.dart';

import '../constant.dart';
import '../res/app_colors.dart';
import '../utils/screen_size.dart';

class PaymentCard extends StatelessWidget {
  final String cardtext;
  final Color cardColor;
  final String imageID;
  final Color outlineColor;
  const PaymentCard(
      {super.key,
      required this.cardtext,
      required this.cardColor,
      required this.outlineColor,
      required this.imageID});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
              top: Displaylandscape
                  ? ScreenSize().getScreenHeight(2)
                  : ScreenSize().getScreenHeight(1),
            ),
            child: Container(
              height: Displaylandscape
                  ? ScreenSize().getScreenHeight(9)
                  : ScreenSize().getScreenHeight(4.8),
              width: Displaylandscape
                  ? ScreenSize().getScreenHeight(9)
                  : ScreenSize().getScreenHeight(4.8),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(width: 2.2, color: outlineColor),
                  borderRadius: BorderRadius.circular(Displaylandscape
                      ? ScreenSize().getScreenHeight(6)
                      : ScreenSize().getScreenHeight(2.4))),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
                top: Displaylandscape
                    ? ScreenSize().getScreenHeight(2.75)
                    : ScreenSize().getScreenHeight(1.4),
                left: Displaylandscape
                    ? ScreenSize().getScreenWidth(0.4)
                    : ScreenSize().getScreenWidth(0.7)),
            child: Container(
              height: Displaylandscape
                  ? ScreenSize().getScreenHeight(7.5)
                  : ScreenSize().getScreenHeight(4),
              width: Displaylandscape
                  ? ScreenSize().getScreenHeight(7.5)
                  : ScreenSize().getScreenHeight(4),
              decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(Displaylandscape
                      ? ScreenSize().getScreenHeight(6)
                      : ScreenSize().getScreenHeight(2.25))),
              child: Padding(
                padding: EdgeInsets.all(ScreenSize().getScreenHeight(1.3)),
                child: Image.asset(
                  imageID,
                  fit: BoxFit.contain,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: Displaylandscape
                    ? ScreenSize().getScreenHeight(1)
                    : ScreenSize().getScreenHeight(1),
                left: Displaylandscape
                    ? ScreenSize().getScreenHeight(1.8)
                    : ScreenSize().getScreenWidth(1.5)),
            child: Text(
              cardtext.toUpperCase(),
              style: TextStyle(
                  fontSize: Displaylandscape
                      ? ScreenSize().getScreenHeight(1.8)
                      : ScreenSize().getScreenHeight(1.1),
                  color: cardColor,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }
}
