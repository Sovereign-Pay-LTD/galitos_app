import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myshop_app/res/app_strings.dart';
import 'package:myshop_app/res/app_theme.dart';
import 'package:myshop_app/services/app_Manager.dart';

import '../../../constant.dart';
import '../../../res/app_colors.dart';
import '../../../utils/fonts_style.dart';
import '../../../utils/screen_size.dart';

import '../../../widgets/switch.dart';

class DebugAndIpaddressSettings extends StatefulWidget {
  const DebugAndIpaddressSettings({super.key});

  @override
  State<DebugAndIpaddressSettings> createState() =>
      _DebugAndIpaddressSettingsState();
}

class _DebugAndIpaddressSettingsState extends State<DebugAndIpaddressSettings> {
  bool ipBtnTap = false;
  bool isDebugMode = false;
  final FocusNode ipFocusNode = FocusNode();
  final TextEditingController ipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)  {
      // Load existing IP address from AppManager

      setState(() async {
        isDebugMode = await AppManager().getDebug();
        ipController.text = AppManager().ipAddress;
      });
    });
  }

  @override
  void dispose() {
    ipFocusNode.dispose();
    ipController.dispose();
    super.dispose();
  }

  void showKeyboard() {
    // Request focus to show the keyboard
    FocusScope.of(context).requestFocus(ipFocusNode);
  }

  void saveIpAddress() {
    if (ipController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter a valid IP address",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    // Validate IP address format
    final ipPattern = RegExp(r'^(\d{1,3}\.){3}\d{1,3}$');

    if (!ipPattern.hasMatch(ipController.text)) {
      Fluttertoast.showToast(
        msg: "Invalid IP address format",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    // Save the IP address
    AppManager().setIpAddress(ipController.text);
    FocusScope.of(context).requestFocus(FocusNode());
AppUtil.toastMessage(message: AppStrings.ipSavedSuccessfully);


    setState(() {
      ipBtnTap = false;
    });
  }

  void cancelEdit() {
    // Reset to saved IP address
    setState(() {
      ipController.text = AppManager().ipAddress;
      ipBtnTap = false;
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ScreenSize().getScreenHeight(2)),

        // Debug Status Section
        Container(
          padding: EdgeInsets.all(ScreenSize().getScreenWidth(3)),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(
              ScreenSize().getScreenHeight(0.5),
            ),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Debug Status',
                    style: FontsStyle().blackText().copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: ScreenSize().getScreenHeight(0.5)),
                  Text(
                    isDebugMode ? 'Debug mode is ON' : 'Debug mode is OFF',
                    style: FontsStyle().blackText().copyWith(
                      fontSize: Displaylandscape
                          ? ScreenSize().getScreenHeight(1.5)
                          : ScreenSize().getScreenHeight(0.9),
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              DebugSwitch(
                onToggle: (bool status) {
                  setState(() {
                    isDebugMode = status;
                  });
                  AppManager().setDebug(status);
                },
              ),
            ],
          ),
        ),

        SizedBox(height: ScreenSize().getScreenHeight(3)),

        // IP Address Section
        if (!isDebugMode) ...[
          Text(
            AppStrings.pinPadIPAddress,
            style: FontsStyle().blackText().copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ScreenSize().getScreenHeight(1)),
          Animate(
            effects: const [
              FadeEffect(duration: Duration(milliseconds: 600)),
              ScaleEffect(duration: Duration(milliseconds: 600)),
            ],
            child: Container(
              padding: EdgeInsets.all(ScreenSize().getScreenWidth(3)),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(
                  ScreenSize().getScreenHeight(0.5),
                ),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Column(
                children: [
                  // IP Address Input
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: Displaylandscape
                              ? ScreenSize().getScreenHeight(5)
                              : ScreenSize().getScreenHeight(4),
                          child: TextField(
                            controller: ipController,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            focusNode: ipFocusNode,
                            readOnly: !ipBtnTap,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Displaylandscape
                                  ? ScreenSize().getScreenHeight(2)
                                  : ScreenSize().getScreenHeight(1.2),
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 2.0,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]'),
                              ),
                            ],
                            maxLength: 15,
                            onChanged: (value) {
                              setState(() {});
                            },
                            textInputAction: TextInputAction.done,
                            onSubmitted: (value) {
                              if (ipBtnTap) {
                                saveIpAddress();
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "IP Address",
                              hintText: "000.000.000.000",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                letterSpacing: 2.0,
                              ),
                              filled: true,
                              fillColor: ipBtnTap
                                  ? Colors.white
                                  : Colors.grey.shade200,
                              counterText: "",
                              labelStyle: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: Displaylandscape
                                    ? ScreenSize().getScreenHeight(1.5)
                                    : ScreenSize().getScreenHeight(0.9),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: ScreenSize().getScreenWidth(2),
                                vertical: ScreenSize().getScreenHeight(1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  ScreenSize().getScreenHeight(0.5),
                                ),
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  ScreenSize().getScreenHeight(0.5),
                                ),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenSize().getScreenWidth(2)),

                      // Edit/Cancel Button
                      InkWell(
                        onTap: () {
                          if (ipBtnTap) {
                            cancelEdit();
                          } else {
                            showKeyboard();
                            setState(() {
                              ipBtnTap = true;
                            });
                          }
                        },
                        child: Container(
                          height: Displaylandscape
                              ? ScreenSize().getScreenHeight(5)
                              : ScreenSize().getScreenHeight(3.4),
                          width: Displaylandscape
                              ? ScreenSize().getScreenHeight(5)
                              : ScreenSize().getScreenHeight(4),
                          decoration: BoxDecoration(
                            color: ipBtnTap
                                ? Colors.red.shade50
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(
                              ScreenSize().getScreenHeight(0.5),
                            ),
                            border: Border.all(
                              width: 1.5,
                              color: ipBtnTap
                                  ? Colors.red.shade300
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              ipBtnTap ? Icons.cancel_outlined : Icons.edit,
                              color: ipBtnTap
                                  ? Colors.red.shade700
                                  : Colors.grey.shade700,
                              size: Displaylandscape
                                  ? ScreenSize().getScreenHeight(2.5)
                                  : ScreenSize().getScreenHeight(2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: ScreenSize().getScreenHeight(2)),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: Displaylandscape
                        ? ScreenSize().getScreenHeight(5)
                        : ScreenSize().getScreenHeight(4),
                    child: ElevatedButton(
                      onPressed: ipController.text.isEmpty || !ipBtnTap
                          ? null
                          : saveIpAddress,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ipController.text.isEmpty || !ipBtnTap
                            ? Colors.grey.shade300
                            : AppColors.secondary,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade300,
                        disabledForegroundColor: Colors.grey.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            ScreenSize().getScreenHeight(0.5),
                          ),
                        ),
                        elevation: ipController.text.isEmpty || !ipBtnTap
                            ? 0
                            : 2,
                      ),
                      child: Text(
                        'SAVE IP ADDRESS',
                        // style: FontsStyle().whiteText().copyWith(
                        //   fontSize: Displaylandscape
                        //       ? ScreenSize().getScreenHeight(1.8)
                        //       : ScreenSize().getScreenHeight(1.1),
                        //   fontWeight: FontWeight.w600,
                        // ),
                      ),
                    ),
                  ),

                  // Current IP Display
                  if (AppManager().ipAddress.isNotEmpty && !ipBtnTap) ...[
                    SizedBox(height: ScreenSize().getScreenHeight(1.5)),
                    Container(
                      padding: EdgeInsets.all(ScreenSize().getScreenWidth(2)),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(
                          ScreenSize().getScreenHeight(0.3),
                        ),
                        border: Border.all(
                          color: Colors.green.shade300,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green.shade700,
                            size: ScreenSize().getScreenHeight(2),
                          ),
                          SizedBox(width: ScreenSize().getScreenWidth(2)),
                          Expanded(
                            child: Text(
                              'Current IP: ${AppManager().ipAddress}',
                              style: TextStyle(
                                fontSize: Displaylandscape
                                    ? ScreenSize().getScreenHeight(1.5)
                                    : ScreenSize().getScreenHeight(0.9),
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],

        // Debug mode message
        if (isDebugMode) ...[
          SizedBox(height: ScreenSize().getScreenHeight(2)),
          Container(
            padding: EdgeInsets.all(ScreenSize().getScreenWidth(3)),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(
                ScreenSize().getScreenHeight(0.5),
              ),
              border: Border.all(color: Colors.orange.shade300, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.orange.shade700,
                  size: ScreenSize().getScreenHeight(2.5),
                ),
                SizedBox(width: ScreenSize().getScreenWidth(2)),
                Expanded(
                  child: Text(
                    'IP address configuration is disabled in debug mode',
                    style: TextStyle(
                      fontSize: Displaylandscape
                          ? ScreenSize().getScreenHeight(1.6)
                          : ScreenSize().getScreenHeight(1),
                      color: Colors.orange.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
