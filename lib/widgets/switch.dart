import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myshop_app/res/app_colors.dart';

import '../services/app_Manager.dart';

class DebugSwitch extends StatefulWidget {
  final void Function (bool status) onToggle;
  const DebugSwitch({super.key, required this.onToggle});

  @override
  State<DebugSwitch> createState() => _DebugSwitchState();
}

class _DebugSwitchState extends State<DebugSwitch> {
  bool debug = false;

  @override
  void initState() {
    super.initState();
    getStatus(); // Load saved value
  }

  getStatus() async {
    bool savedDebug = await AppManager().getDebug();
    setState(() {
      debug = savedDebug;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: debug,
      activeColor: AppColors.primary,
      onChanged: (value) async {
        setState(() {
          debug = value;
        });
widget.onToggle(debug);
        // Save in singleton + SharedPreferences


      },
    );
  }
}