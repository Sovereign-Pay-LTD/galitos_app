import 'package:flutter/material.dart';
import 'package:myshop_app/models/countryData.dart';
import 'package:myshop_app/res/app_strings.dart';
import 'package:myshop_app/res/app_theme.dart';
import 'package:myshop_app/services/country_currency_Manager.dart';
import '../constant.dart';
import '../models/productCategory.dart';
import '../res/app_colors.dart';
import '../res/app_drawables.dart';
import '../utils/currency_format.dart';
import '../utils/screen_size.dart';


class Footer extends StatelessWidget {
  final List<Item>  cartList;
  final double  amount;
  final Function () onViewCart;
  final Function () onPay;
  const Footer({super.key, required this.cartList, required this.onPay, required this.amount, required this.onViewCart});

  @override
  Widget build(BuildContext context) {

  CountryData  activeCurrency = CountryManager().activeCountry ;
    return  SizedBox(
        height: Displaylandscape
            ? ScreenSize().getScreenHeight(8)
            : ScreenSize().getScreenHeight(4.5),
        width: double.infinity,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: cartList.isEmpty
                    ? () {
                  AppUtil.toastMessage(message:AppStrings.pleaseAddAnItemToTheCart);
                }
                    : () {
                  onViewCart();

                },
                child: Container(
                  width: ScreenSize().getScreenWidth(50),
                  height: Displaylandscape
                      ? ScreenSize().getScreenHeight(8)
                      : ScreenSize().getScreenHeight(4.5),
                  color: AppColors.primaryDark,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  AppDrawables.carGray,
                                  height: Displaylandscape
                                      ? ScreenSize()
                                      .getScreenHeight(4)
                                      : ScreenSize()
                                      .getScreenHeight(2.5),
                                  color: cartList.isEmpty
                                      ? null
                                      : Colors.white,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: cartList.isEmpty
                                    ? const SizedBox.shrink()
                                    : Padding(
                                  padding: EdgeInsets.only(
                                      bottom: Displaylandscape
                                          ? ScreenSize()
                                          .getScreenHeight(
                                          5)
                                          : ScreenSize()
                                          .getScreenHeight(
                                          2.5),
                                      left: Displaylandscape
                                          ? ScreenSize()
                                          .getScreenWidth(
                                          2.7)
                                          : ScreenSize()
                                          .getScreenWidth(
                                          4)),
                                  child: Container(
                                    height: Displaylandscape
                                        ? ScreenSize()
                                        .getScreenHeight(
                                        2)
                                        : ScreenSize()
                                        .getScreenHeight(
                                        1.4),
                                    width: Displaylandscape
                                        ? ScreenSize()
                                        .getScreenHeight(
                                        2)
                                        : ScreenSize()
                                        .getScreenHeight(
                                        1.4),
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(
                                            Displaylandscape
                                                ? ScreenSize()
                                                .getScreenHeight(
                                                1)
                                                : ScreenSize()
                                                .getScreenHeight(
                                                0.8))),
                                    child: Center(
                                      child: Text(
                                        cartList.length
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: Displaylandscape
                                                ? ScreenSize()
                                                .getScreenHeight(
                                                1)
                                                : ScreenSize()
                                                .getScreenHeight(
                                                0.8),
                                            color:
                                            Colors.white,
                                            fontWeight:
                                            FontWeight
                                                .w300),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: ScreenSize().getScreenWidth(0.5),
                          ),
                          cartList.isEmpty
                              ? const SizedBox.shrink()
                              : Text(
                            activeCurrency.symbol! +
                                Currency().format(
                                  decimal: activeCurrency.dp!,
                                    rate: double.parse(activeCurrency.rate??"1"),
                                  amount: amount),
                            style: TextStyle(
                                fontSize: Displaylandscape
                                    ? ScreenSize()
                                    .getScreenHeight(4)
                                    : ScreenSize()
                                    .getScreenHeight(2),
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap:cartList.isEmpty
                      ? () {
                    AppUtil.toastMessage(message: AppStrings.pleaseAddAnItemToTheCart);
                  }
                      : () {
                    onPay();

                  },
                  child: Container(
                    width: ScreenSize().getScreenWidth(50),
                    height: Displaylandscape
                        ? ScreenSize().getScreenHeight(8)
                        : ScreenSize().getScreenHeight(4.5),
                    color: cartList.isEmpty
                        ? AppColors.primaryDark.withOpacity(0.7)
                        : AppColors.secondary,
                    child: Center(
                      child: Text(
                        AppStrings.payNow,
                        style: TextStyle(
                            fontSize: Displaylandscape
                                ? ScreenSize().getScreenHeight(4)
                                : ScreenSize().getScreenHeight(1.5),
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }
}
