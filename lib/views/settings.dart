import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myshop_app/res/app_strings.dart';
import '../constant.dart';
import '../res/app_colors.dart';
import '../services/app_Manager.dart';
import '../services/country_currency_Manager.dart';
import '../utils/fonts_style.dart';
import '../utils/screen_size.dart';
import 'components/settings_screen/country_SetUp_config.dart';
import 'components/settings_screen/debug_and_ipaddress_settings.dart';
import 'components/settings_screen/header.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isCurrencySettings = true;
  bool ipBtnTap = false;
  String btnTitle = 'Currency';
  final FocusNode ipfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isCurrencySettings = AppManager().isCurrencyConfig;
      });
    });
    // Add listener to rebuild when AppManager changes
    _startListening();
  }

  void _startListening() {
    // Check AppManager state every 100ms to detect changes
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        final newState = AppManager().isCurrencyConfig;
        if (newState != isCurrencySettings) {
          setState(() {
            isCurrencySettings = newState;
            btnTitle = isCurrencySettings ? 'Currency' : 'Pin Pad';
          });
        }
        _startListening();
      }
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the widget is disposed
    ipfocusNode.dispose();
    super.dispose();
  }

  void showKeyboard() {
    // Request focus to show the keyboard
    FocusScope.of(context).requestFocus(ipfocusNode);
  }

  void toggleSettings(bool isCurrency) {
    setState(() {
      isCurrencySettings = isCurrency;
      btnTitle = isCurrencySettings ? 'Currency' : 'Pin Pad';
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with toggle buttons
            const Header(),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: ScreenSize().getScreenHeight(1.3),
              ),
              child: Text(
                isCurrencySettings
                    ? 'Currency Configuration'
                    : 'Pin pad Settings',
                style: FontsStyle().functionText(),
              ),
            ),

            // Currency Settings Header
            if (isCurrencySettings)
              Animate(
                effects: const [
                  FadeEffect(duration: Duration(milliseconds: 600)),
                  ScaleEffect(duration: Duration(milliseconds: 600)),
                ],
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize().getScreenWidth(2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: Text(
                            'Country',
                            style: FontsStyle().blackText(),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Displaylandscape
                                  ? ScreenSize().getScreenWidth(14)
                                  : ScreenSize().getScreenWidth(10),
                              child: Center(
                                child: Text(
                                  'Rate',
                                  style: FontsStyle().blackText(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Displaylandscape
                                  ? ScreenSize().getScreenWidth(14)
                                  : ScreenSize().getScreenWidth(10),
                              child: Center(
                                child: Text(
                                  'Symbol',
                                  style: FontsStyle().blackText(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Displaylandscape
                                  ? ScreenSize().getScreenWidth(14)
                                  : ScreenSize().getScreenWidth(10),
                              child: Center(
                                child: Text(
                                  'Code',
                                  style: FontsStyle().blackText(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Displaylandscape
                                  ? ScreenSize().getScreenWidth(14)
                                  : ScreenSize().getScreenWidth(10),
                              child: Center(
                                child: Text(
                                  'Decimal',
                                  style: FontsStyle().blackText(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Displaylandscape
                                  ? ScreenSize().getScreenHeight(6)
                                  : ScreenSize().getScreenHeight(4),
                              child: Center(
                                child: Text(
                                  'Edit',
                                  style: FontsStyle().blackText(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Divider
            if (isCurrencySettings)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize().getScreenWidth(2),
                  vertical: ScreenSize().getScreenHeight(0.5),
                ),
                child: Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
              ),

            // Content area
            Expanded(
              child: isCurrencySettings
                  ? const CountrySetupConfig()
                  : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize().getScreenWidth(5),
                  ),
                  child: const DebugAndIpaddressSettings(),
                ),
              ),
            ),

            // Bottom action buttons
            if (isCurrencySettings)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize().getScreenWidth(5),
                  vertical: ScreenSize().getScreenHeight(2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Reset to defaults
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:  Text(AppStrings.resetSettings),
                              content: const Text(
                                  AppStrings.resetAlert),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child:  Text(AppStrings.cancel.toLowerCase() ,style: TextStyle(color: AppColors.primary),),
                                ),
                                TextButton(
                                  onPressed: () {
                                    CountryManager().resetToDefaults();
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                      msg: AppStrings.resetToDefaultSettings,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  },
                                  child:  Text(AppStrings.reset,style: TextStyle(color: AppColors.primary)),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                            vertical: ScreenSize().getScreenHeight(1.5),
                          ),
                        ),
                        child: Text(
                         AppStrings.reset,
                          style: FontsStyle().blackText(),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenSize().getScreenWidth(3)),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Save settings
                         CountryManager().saveCountrySettings();

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: ScreenSize().getScreenHeight(1.5),
                          ),
                        ),
                        child: Text(
                          AppStrings.save

                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}