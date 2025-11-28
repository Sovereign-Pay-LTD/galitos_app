import 'package:flutter/material.dart';
import '../res/app_drawables.dart';

Future<void> precacheAppImages(BuildContext context) async {
  // List of all raster images in AppDrawables
  final rasterImages = [
    AppDrawables.success,
    AppDrawables.failed,
    AppDrawables.logo,
  AppDrawables.carGray,
  AppDrawables.payArrow ,
  AppDrawables.printLogo ,
  AppDrawables.card ,
  AppDrawables.mobile,
  AppDrawables.success ,
  AppDrawables.cancel  ,
  AppDrawables.arrowRightGif ,
  AppDrawables.header,
  AppDrawables.btn ,
  AppDrawables.drink,
  AppDrawables.drinkOne ,
  AppDrawables.drinkTwo ,
  AppDrawables.drinkThree ,
  AppDrawables.drinkFour,
  AppDrawables.drinkFive ,
  AppDrawables.drinkSix ,
   AppDrawables.drinkSeven,
   AppDrawables.drinkEight,
   AppDrawables.snacks ,
   AppDrawables.snackOne ,
   AppDrawables.snackTwo ,
   AppDrawables.snackThree ,
   AppDrawables.snackFour ,
   AppDrawables.snackFive ,
   AppDrawables.snackSix ,
   AppDrawables.snackSeven ,
   AppDrawables.snackEight,
   AppDrawables.failed,
   AppDrawables.qr ,
  

  ];

  for (final imagePath in rasterImages) {
    await precacheImage(
      AssetImage(imagePath),
      context,
      onError: (exception, stackTrace) {
        debugPrint('❌ Failed to precache raster image $imagePath: $exception');
      },
    );
  }

  debugPrint('✅ All app images precached successfully!');
}
