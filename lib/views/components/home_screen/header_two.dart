import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constant.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_strings.dart';
import '../../../utils/screen_size.dart';

class HeaderTwo extends StatefulWidget {
  const HeaderTwo({super.key});

  @override
  State<HeaderTwo> createState() => _HeaderTwoState();
}

class _HeaderTwoState extends State<HeaderTwo> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      height: Displaylandscape
          ? ScreenSize().getScreenHeight(4.5)
          : ScreenSize().getScreenHeight(3),
      width: double.infinity,
      color: AppColors.secondary,
      child: Center(
        child: Text(
          AppStrings.moto.toUpperCase(),
          style: TextStyle(
              fontSize: Displaylandscape
                  ? ScreenSize().getScreenHeight(2)
                  : ScreenSize().getScreenHeight(1.2),
              color: Colors.white,
              wordSpacing: Displaylandscape
                  ? ScreenSize().getScreenWidth(0.5)
                  : ScreenSize().getScreenWidth(0),
              fontWeight: FontWeight.w600),
        )
            .animate()
            .fadeIn(duration: 800.ms)
            .then(delay: 600.ms) // baseline=800ms
            .slide(),
      ),
    );
  }
}
