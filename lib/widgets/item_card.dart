import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myshop_app/res/app_drawables.dart';
import 'package:myshop_app/res/app_strings.dart';
import '../constant.dart';
import '../models/countryData.dart';
import '../models/productCategory.dart';
import '../res/app_colors.dart';
import '../services/country_currency_Manager.dart';
import '../utils/currency_format.dart';
import '../utils/screen_size.dart';

class ItemCard extends StatefulWidget {
  final Item item;
  final void Function(Item selectedProduct) onAddToCart;
  final void Function(Item selectedProduct) onCartItemUpdate;
  final void Function(Item selectedProduct) onRemoveItem;
  final List<Item> cartList;

  const ItemCard({
    super.key,
    required this.item,
    required this.onAddToCart,
    required this.cartList,
    required this.onCartItemUpdate,
    required this.onRemoveItem,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    CountryData activeCurrency = CountryManager().activeCountry;
    bool isInCart = widget.cartList.contains(widget.item);
    return Animate(
      effects: const [
        FadeEffect(duration: Duration(milliseconds: 600)),
        ScaleEffect(duration: Duration(milliseconds: 600)),
      ],
      child: GestureDetector(
        onTap: () {
          setState(() {
            isPressed = true;
          });

          Timer(const Duration(milliseconds: 100), () {
            setState(() {
              isPressed = false;
            });
          });

          widget.onAddToCart(widget.item);
        },
        child: Card(
          shadowColor: Colors.black26,
          elevation: 2,
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: const Color.fromARGB(20, 194, 193, 193),
              borderRadius: BorderRadius.circular(
                ScreenSize().getScreenHeight(Displaylandscape ? 2 : 1),
              ),
              border: isPressed
                  ? Border.all(width: 2, color: AppColors.primary)
                  : Border.all(width: 0, color: Colors.transparent),
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: ScreenSize().getScreenHeight(0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Image.asset(
                        widget.item.image!,
                        fit: BoxFit.contain,
                        height: ScreenSize().getScreenHeight(3.5),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppDrawables.btn),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(
                          Displaylandscape
                              ? ScreenSize().getScreenHeight(2)
                              : ScreenSize().getScreenHeight(1),
                        ),
                        bottomLeft: Radius.circular(
                          Displaylandscape
                              ? ScreenSize().getScreenHeight(2)
                              : ScreenSize().getScreenHeight(1),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenSize().getScreenHeight(
                              Displaylandscape ? 1 : 0.5,
                            ),
                          ),
                          child: Text(
                            widget.item.name ?? 'N/A',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: Displaylandscape
                                  ? ScreenSize().getScreenHeight(2.2)
                                  : ScreenSize().getScreenHeight(1),
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: ScreenSize().getScreenHeight(1),
                            left: ScreenSize().getScreenHeight(1),
                            right: ScreenSize().getScreenHeight(1),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: ScreenSize().getScreenHeight(
                                    Displaylandscape ? 0.5 : 0.2,
                                  ),
                                ),
                                child: Text(
                                  activeCurrency.symbol! +
                                      Currency().format(
                                        decimal: activeCurrency.dp!,
                                        rate: double.parse(
                                          activeCurrency.rate!,
                                        ),
                                        amount: widget.item.price ?? 0,
                                      ),
                                  style: TextStyle(
                                    fontSize: Displaylandscape
                                        ? ScreenSize().getScreenHeight(2)
                                        : ScreenSize().getScreenHeight(0.9),
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              isInCart
                                  ? showItmQty(context, widget.item)
                                  : Container(
                                      height: Displaylandscape
                                          ? ScreenSize().getScreenHeight(5)
                                          : ScreenSize().getScreenHeight(2.35),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                          (Displaylandscape ? 5 : 5),
                                        ),
                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                      child: SizedBox(
                                        height: ScreenSize().getScreenHeight(
                                          Displaylandscape ? 2.1 : 1.0,
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: ScreenSize()
                                                      .getScreenHeight(0.15),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: AppColors.secondary,
                                                  size: ScreenSize()
                                                      .getScreenHeight(
                                                        Displaylandscape
                                                            ? 2.1
                                                            : 1.0,
                                                      ),
                                                ),
                                              ),
                                              Text(
                                                AppStrings.add,
                                                style: TextStyle(
                                                  fontSize: Displaylandscape
                                                      ? ScreenSize()
                                                            .getScreenHeight(2)
                                                      : ScreenSize()
                                                            .getScreenHeight(
                                                              0.9,
                                                            ),
                                                  color: AppColors.secondary,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showItmQty(context, Item item) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: Displaylandscape
            ? ScreenSize().getScreenHeight(5)
            : ScreenSize().getScreenHeight(2.35),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(217, 217, 217, 1),
          borderRadius: BorderRadius.circular((Displaylandscape ? 5 : 3)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize().getScreenWidth(0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: item.qty! <= 1
                    ? () {
                        widget.onRemoveItem(item);
                      }
                    : () {
                        item.qty = (item.qty! - 1);
                        widget.onCartItemUpdate(item);
                      },
                child: Container(
                  height: ScreenSize().getScreenHeight(
                    Displaylandscape ? 3.5 : 1.6,
                  ),
                  width: ScreenSize().getScreenHeight(
                    Displaylandscape ? 3.5 : 1.6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(
                      ScreenSize().getScreenHeight(
                        Displaylandscape ? 1.8 : 0.8,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      color: Colors.red,
                      size: ScreenSize().getScreenHeight(
                        Displaylandscape ? 2.5 : 1.3,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                item.qty.toString(),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  fontSize: Displaylandscape
                      ? ScreenSize().getScreenHeight(2.2)
                      : ScreenSize().getScreenHeight(1.2),
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  item.qty = (item.qty! + 1);
                  widget.onCartItemUpdate(item);
                },
                child: Container(
                  height: ScreenSize().getScreenHeight(
                    Displaylandscape ? 3.5 : 1.6,
                  ),
                  width: ScreenSize().getScreenHeight(
                    Displaylandscape ? 3.5 : 1.6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      ScreenSize().getScreenHeight(
                        Displaylandscape ? 1.8 : 0.8,
                      ),
                    ),
                    border: Border.all(width: 1, color: AppColors.secondary),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: AppColors.secondary,
                      size: ScreenSize().getScreenHeight(
                        Displaylandscape ? 2.5 : 1.3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
