import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myshop_app/nav/app_navigator.dart';
import 'package:myshop_app/services/app_Manager.dart';

import '../../../constant.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_drawables.dart';
import '../../../utils/screen_size.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Displaylandscape
          ? ScreenSize().getScreenHeight(10)
          : ScreenSize().getScreenHeight(5.5),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppDrawables.header),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize().getScreenWidth(3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            InkWell(
              onTap: () {
                AppNavigator.gotoHome(context: context);
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: Displaylandscape
                        ? ScreenSize().getScreenHeight(4)
                        : ScreenSize().getScreenHeight(2),
                    color: Colors.black,
                  ),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: Displaylandscape
                          ? ScreenSize().getScreenHeight(2)
                          : ScreenSize().getScreenHeight(1.3),
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Toggle buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Currency button
                InkWell(
                  onTap: () {
                    setState(() {
                      AppManager().setCurrencyConfig(true);
                    });
                  },
                  child: Container(
                    height: Displaylandscape
                        ? ScreenSize().getScreenHeight(5)
                        : ScreenSize().getScreenHeight(2.5),
                    width: Displaylandscape
                        ? ScreenSize().getScreenHeight(10)
                        : ScreenSize().getScreenHeight(6),
                    decoration: BoxDecoration(
                      color: AppManager().isCurrencyConfig
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.transparent,
                      border: Border.all(
                        width: 2,
                        color: AppManager().isCurrencyConfig
                            ? AppColors.primary
                            : Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(
                        ScreenSize().getScreenHeight(0.3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Currency',
                        style: TextStyle(
                          fontSize: Displaylandscape
                              ? ScreenSize().getScreenHeight(2)
                              : ScreenSize().getScreenHeight(1),
                          color: AppManager().isCurrencyConfig
                              ? AppColors.primary
                              : Colors.black54,
                          fontWeight: AppManager().isCurrencyConfig
                              ? FontWeight.w700
                              : FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ScreenSize().getScreenWidth(2)),

                // Pinpad Settings button
                InkWell(
                  onTap: () {
                    setState(() {
                      AppManager().setCurrencyConfig(false);
                    });
                  },
                  child: Container(
                    height: Displaylandscape
                        ? ScreenSize().getScreenHeight(5)
                        : ScreenSize().getScreenHeight(2.5),
                    width: Displaylandscape
                        ? ScreenSize().getScreenHeight(20)
                        : ScreenSize().getScreenHeight(8.5),
                    decoration: BoxDecoration(
                      color: !AppManager().isCurrencyConfig
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.transparent,
                      border: Border.all(
                        width: 2,
                        color: !AppManager().isCurrencyConfig
                            ? AppColors.primary
                            : Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(
                        ScreenSize().getScreenHeight(0.3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Pinpad Settings',
                        style: TextStyle(
                          fontSize: Displaylandscape
                              ? ScreenSize().getScreenHeight(2)
                              : ScreenSize().getScreenHeight(1),
                          color: !AppManager().isCurrencyConfig
                              ? AppColors.primary
                              : Colors.black54,
                          fontWeight: !AppManager().isCurrencyConfig
                              ? FontWeight.w700
                              : FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}