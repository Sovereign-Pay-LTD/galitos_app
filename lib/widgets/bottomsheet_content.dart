import 'package:flutter/material.dart';
import 'package:myshop_app/nav/app_navigator.dart';
import 'package:myshop_app/res/app_strings.dart';
import 'package:myshop_app/widgets/payment_modal.dart';
import '../blocs/screens/home/bloc.dart';
import '../constant.dart';
import '../models/countryData.dart';
import '../res/app_colors.dart';
import '../services/country_currency_Manager.dart';
import '../utils/currency_format.dart';
import '../utils/fonts_style.dart';
import '../utils/screen_size.dart';
import 'footer.dart';

class SheetContent extends StatelessWidget {
  final HomeBloc homeBloc;
  const SheetContent({super.key, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    CountryData activeCurrency = CountryManager().activeCountry;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize().getScreenWidth(3),
            vertical: ScreenSize().getScreenHeight(1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.cart,
                style: TextStyle(
                  fontSize: Displaylandscape
                      ? ScreenSize().getScreenHeight(2.5)
                      : ScreenSize().getScreenHeight(1.5),
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              InkWell(
                onTap: () {
                  homeBloc.add(HomeEmptyCartEvent());
                  Navigator.pop(context);
                },
                child: Text(
                  AppStrings.empty,
                  style: TextStyle(
                    fontSize: Displaylandscape
                        ? ScreenSize().getScreenHeight(2.5)
                        : ScreenSize().getScreenHeight(1.5),
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize().getScreenWidth(3),
          ),
          child: Container(
            width: double.infinity,
            height: Displaylandscape
                ? ScreenSize().getScreenHeight(4.5)
                : ScreenSize().getScreenHeight(3.5),
            decoration: const BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(width: 1, color: Colors.black12),
              ),
            ),
            child: Center(
              child: Table(
                border: const TableBorder.symmetric(),
                children: [
                  TableRow(
                    children: [
                      Text(
                        AppStrings.quantity,
                        style: FontsStyle().tabletitle(),
                      ),
                      Text(AppStrings.name, style: FontsStyle().tabletitle()),
                      Text(
                        '${AppStrings.amount}(${activeCurrency.symbol})',
                        style: FontsStyle().tabletitle(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Displaylandscape
                              ? ScreenSize().getScreenHeight(3)
                              : ScreenSize().getScreenHeight(6),
                        ),
                        child: Text(
                          AppStrings.remove,
                          style: FontsStyle().tabletitle(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white70,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize().getScreenWidth(3),
            ),
            child: ListView.builder(
              itemCount: homeBloc.metaData.cart.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: double.infinity,
                  height: Displaylandscape
                      ? ScreenSize().getScreenHeight(4)
                      : ScreenSize().getScreenHeight(2.5),
                  child: Center(
                    child: Table(
                      //  border: TableBorder.(bottom:BorderSide),
                      children: [
                        TableRow(
                          children: [
                            Text(
                              homeBloc.metaData.cart[index].qty.toString(),
                              style: FontsStyle().tabledata(),
                            ),
                            Text(
                              homeBloc.metaData.cart[index].name.toString(),
                              style: FontsStyle().tabledata(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: ScreenSize().getScreenWidth(2),
                              ),
                              child: Text(
                                Currency().format(
                                  decimal: activeCurrency.dp!,
                                  rate: double.parse(
                                    activeCurrency.rate ?? '1',
                                  ),
                                  amount:
                                      homeBloc.metaData.cart[index].price ?? 0,
                                ),
                                style: FontsStyle().tabledata(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: Displaylandscape
                                    ? ScreenSize().getScreenWidth(12)
                                    : ScreenSize().getScreenWidth(0),
                              ),
                              child: GestureDetector(
                                onTap: () {


                                  if (homeBloc.metaData.cart.length == 1) {
                                    homeBloc.add(
                                      HomeRemoveEvent(
                                        selectedProduct:
                                        homeBloc.metaData.cart[index],
                                      ),
                                    );
                                    AppNavigator.gotoHome(context: context);
                                  }else{
                                    homeBloc.add(
                                      HomeRemoveEvent(
                                        selectedProduct:
                                        homeBloc.metaData.cart[index],
                                      ),
                                    );
                                  }

                                },
                                child: Icon(
                                  Icons.delete_outlined,
                                  color: Colors.red,
                                  size: Displaylandscape
                                      ? ScreenSize().getScreenHeight(3)
                                      : ScreenSize().getScreenHeight(1.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize().getScreenWidth(3),
            vertical: ScreenSize().getScreenHeight(1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.total,
                style: TextStyle(
                  fontSize: Displaylandscape
                      ? ScreenSize().getScreenHeight(4)
                      : ScreenSize().getScreenHeight(2.5),
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                Currency().format(
                  decimal: activeCurrency.dp!,
                  rate: double.parse(activeCurrency.rate!),
                  amount: homeBloc.metaData.cartTotalAmount,
                ),
                style: TextStyle(
                  fontSize: Displaylandscape
                      ? ScreenSize().getScreenHeight(4.5)
                      : ScreenSize().getScreenHeight(2.5),
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Footer(
          cartList: homeBloc.metaData.cart,
          onPay: () {
            Navigator.pop(context);
            paymentModal( context: context, transactionData:  homeBloc.metaData);
          },
          amount: homeBloc.metaData.cartTotalAmount,
          onViewCart: () {
            Navigator.pop(context);

          },
        ),
      ],
    );
  }
}
