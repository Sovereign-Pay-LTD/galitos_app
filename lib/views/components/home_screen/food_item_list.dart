import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_grid_view/group_grid_view.dart';
import 'package:myshop_app/blocs/screens/home/bloc.dart';

import '../../../constant.dart';
import '../../../models/productCategory.dart';
import '../../../utils/screen_size.dart';
import '../../../widgets/item_card.dart';

class FoodItemList extends StatefulWidget {
  final void Function(Item selectedProduct) onAddToCart;
  final  HomeBloc  homeBloc;
  const FoodItemList({
    super.key,
    required this.onAddToCart,
    required this.homeBloc,
  });

  @override
  State<FoodItemList> createState() => _FoodItemListState();
}

class _FoodItemListState extends State<FoodItemList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: Displaylandscape
              ? ScreenSize().getScreenWidth(9)
              : ScreenSize().getScreenWidth(3),
          right: Displaylandscape
              ? ScreenSize().getScreenWidth(9)
              : ScreenSize().getScreenWidth(3),
        ),
        child: SizedBox(
          height: ScreenSize().getScreenHeight(84),
          child: GroupGridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: Displaylandscape ? 10 : 16,
              crossAxisSpacing: 16,
              childAspectRatio: Displaylandscape ? 0.9 : 0.7,
            ),
            sectionCount: DATA.length,
            headerForSection: (section) => Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Image.asset(
                    '${DATA[section].icon}',
                    height: Displaylandscape
                        ? ScreenSize().getScreenHeight(2)
                        : ScreenSize().getScreenHeight(1.3),
                  ),
                  SizedBox(width: ScreenSize().getScreenWidth(1)),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Displaylandscape
                          ? ScreenSize().getScreenHeight(0.1)
                          : ScreenSize().getScreenHeight(0.3),
                    ),
                    child: Text(
                      DATA[section].category!,
                      style: TextStyle(
                        fontSize: Displaylandscape
                            ? ScreenSize().getScreenHeight(2)
                            : ScreenSize().getScreenHeight(1.2),
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            itemInSectionBuilder: (_, indexPath) {
              Item? productData =
                  DATA[indexPath.section].items?[indexPath.index];

              return ItemCard(
                item: productData ?? Item(),
                onAddToCart: (Item selectedProduct) {
                  widget.onAddToCart(productData!);
                },
                cartList: widget.homeBloc.metaData.cart,
                onCartItemUpdate: (Item selectedProduct) {
                  widget.homeBloc.add(HomeUpdateCartItemEvent(selectedProduct: selectedProduct));
                },
                onRemoveItem: (Item selectedProduct) {
                  widget.homeBloc.add(HomeRemoveEvent(selectedProduct: selectedProduct));
                },
              );
            },
            itemInSectionCount: (section) => DATA[section].items!.length,
          ),
        ),
      ),
    );
  }
}
