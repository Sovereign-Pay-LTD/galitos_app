import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:myshop_app/blocs/screens/home/bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../../constant.dart';
import '../../../models/countryData.dart';
import '../../../res/app_drawables.dart';
import '../../../services/country_currency_Manager.dart';
import '../../../utils/screen_size.dart';
import '../../settings.dart';

class whiteHeader extends StatefulWidget {
  final HomeBloc homeBloc;
  const whiteHeader({super.key, required this.homeBloc});

  @override
  State<whiteHeader> createState() => _whiteHeaderState();
}

class _whiteHeaderState extends State<whiteHeader> {
  @override
  Widget build(BuildContext context) {

    CountryData activeCurrency = CountryManager().activeCountry;
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
            InkWell(
              onTap: () {
                //====
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 10),
                    reverseDuration: const Duration(milliseconds: 10),
                    child: const Settings(),
                    inheritTheme: true,
                    ctx: context,
                  ),
                );
              },
              child: Icon(
                Icons.settings_outlined,
                size: Displaylandscape
                    ? ScreenSize().getScreenHeight(4)
                    : ScreenSize().getScreenHeight(2),
                color: Colors.black,
              ),
            ),
            Image.asset(
              AppDrawables.logo,
              height: Displaylandscape
                  ? ScreenSize().getScreenHeight(6)
                  : ScreenSize().getScreenHeight(3),
            ),
            Row(
              children: [
                SizedBox(
                  height: Displaylandscape
                      ? ScreenSize().getScreenHeight(3)
                      : ScreenSize().getScreenHeight(2),
                  child: DropdownButton(
                    isDense: false,
                    underline: const SizedBox(),
                    // itemHeight: ScreenSize().getScreenHeight(1),
                    // Initial Value
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: Displaylandscape
                          ? ScreenSize().getScreenHeight(3)
                          : ScreenSize().getScreenHeight(2),
                    ),
                    elevation: 5,
                    value: activeCurrency.code,

                    // Down Arrow Icon
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                      size: Displaylandscape
                          ? ScreenSize().getScreenHeight(3)
                          : ScreenSize().getScreenHeight(1.2),
                    ),

                    // Array list of items
                    items: CountryManager().countryMetaData.map<DropdownMenuItem<String>>((
                      CountryData c,
                    ) {
                      return DropdownMenuItem<String>(
                        value: c.code, // or c.countryCode / c.name
                        child: Text(
                          c.code ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: Displaylandscape
                                ? ScreenSize().getScreenHeight(3)
                                : ScreenSize().getScreenHeight(1.2),
                          ),
                        ),
                      );
                    }).toList(),

                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      widget.homeBloc.add(
                        HomeSetCurrencyAndCountryEvent(code: newValue!),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Displaylandscape
                      ? ScreenSize().getScreenHeight(4)
                      : ScreenSize().getScreenHeight(2),
                  width: Displaylandscape
                      ? ScreenSize().getScreenWidth(1)
                      : null,
                  child: const VerticalDivider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FlutterExitApp.exitApp();
                  },
                  child: Icon(
                    Icons.power_settings_new,
                    size: Displaylandscape
                        ? ScreenSize().getScreenHeight(4)
                        : ScreenSize().getScreenHeight(2),
                    color: const Color.fromRGBO(225, 0, 36, 1),
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
