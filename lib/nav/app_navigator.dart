import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../blocs/screens/home/bloc.dart';
import '../views/home_screen.dart';



class AppNavigator {
  static const String setting = "setting";
  static const String home = "home_screens";

  AppNavigator._();



  // ---------------- Home ----------------
  static Future gotoHome({
    required BuildContext context,
  }) async {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 1),
        reverseDuration: const Duration(milliseconds: 1),
        child: const HomeScreen(),
        inheritTheme: true,
        ctx: context,
      ),
    );
  }
}
    // Wrap all blocs using MultiBlocProvider i
