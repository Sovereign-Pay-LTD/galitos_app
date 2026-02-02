import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myshop_app/nav/app_navigator.dart';
import 'package:myshop_app/res/app_colors.dart';
import 'package:myshop_app/res/app_drawables.dart';
import 'package:myshop_app/res/app_strings.dart';
import 'package:myshop_app/utils/cached_Images.dart';
import 'package:myshop_app/views/home_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final renderView = WidgetsBinding.instance.renderViewElement;
    if (renderView != null) {
      await precacheAppImages(renderView); // your async precache function
    }
    // Allow first frame to render
    WidgetsBinding.instance.allowFirstFrame();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.myShop,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        fontFamily: AppStrings.fontFamily,
      ),
      home: AnimatedSplashScreen(
          duration: 900,
          function: ()=> AppNavigator.gotoHome(context: context),
          splash: Container(
              height: 160,
              width: 200,
              color: AppColors.white,
              child: Column(
                children: [
                  Image.asset(
                    AppDrawables.logo,
                    fit: BoxFit.contain,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: AppColors.secondary,
                        )),
                  ),
                ],
              )),
          nextScreen: const HomeScreen(),
          splashTransition: SplashTransition.slideTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: AppColors.white),
    );
  }
}


