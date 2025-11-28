import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:myshop_app/services/country_currency_Manager.dart";
import "../../../models/flowData.dart";
import "../../../models/productCategory.dart";
import "../../../nav/app_navigator.dart";
import "../../../res/app_theme.dart";
part "event.dart";
part "state.dart";



class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BuildContext sectionContext;
  late FlowData metaData;

  HomeBloc({required this.sectionContext}) : super(HomeInitState()) {
    metaData = FlowData(cartTotalAmount: 0, cart: []);

    // Initialize country data safely (async)
    _initCountryData();

    on<HomeSetCurrencyAndCountryEvent>((event, emit) async {
      // Set selected country
      await CountryManager().dropdownSelectedCountry(event.code);
      await CountryManager().changeCurrency(sectionContext, event.code);
      // Update metaData
      metaData.countryData = await CountryManager().getCountryData(sectionContext);
print(metaData.countryData?.toJson());
      AppNavigator.gotoHome(context: sectionContext);
    });

    on<HomeEmptyCartEvent>((event, emit) {
      metaData.cart = [];
      metaData.cartTotalAmount = 0;
      emit(HomeUpdatedCartState());
    });

    on<HomeRemoveEvent>((event, emit) async {
      final Item item = event.selectedProduct;
      metaData.cart.removeWhere((e) => AppUtil.isSameItem(e, item));
      await updateCartTotalAmount();
      emit(HomeUpdatedCartState());
    });

    on<HomeUpdateCartItemEvent>((event, emit) async {
      final Item item = event.selectedProduct;
      final existingIndex =
      metaData.cart.indexWhere((e) => AppUtil.isSameItem(e, item));

      if (existingIndex != -1) {
        metaData.cart[existingIndex].totalAmount =
            item.price! * item.qty!;
      }

      await updateCartTotalAmount();
      emit(HomeInitState());
    });

    on<HomeOnExitEvent>((event, emit) {
      metaData = event.metaData;
      emit(HomeInitState());
    });

    on<HomePaymentOptionEvent>((event, emit) {
      metaData = event.metaData;
      emit(HomePaymentOption(metaData: metaData));
    });

    on<HomeProgressEvent>((event, emit) {
      metaData = event.metaData;
      emit(HomeProgress(metaData: metaData));
    });

    on<HomeAddToCartEvent>((event, emit) async {
      Item item = event.selectedProduct;
      int qty = item.qty!;

      final existingIndex =
      metaData.cart.indexWhere((e) => AppUtil.isSameItem(e, item));

      if (existingIndex != -1) {
        metaData.cart[existingIndex].qty =
        (metaData.cart[existingIndex].qty! + qty);
        metaData.cart[existingIndex].totalAmount =
            item.price! * metaData.cart[existingIndex].qty!;
      } else {
        item.totalAmount = item.price! * qty;
        metaData.cart.add(item);
      }

      await updateCartTotalAmount();
      emit(HomeInitState());
    });

    on<HomeLogoutEvent>((event, emit) {
      AppNavigator.gotoHome(context: sectionContext);
    });

    on<HomeBackEvent>((event, emit) {
      emit(HomeInitState());
    });
  }

  // -----------------------------
  // Async initialization helper
  // -----------------------------
  void _initCountryData() async {
    metaData.countryData = await CountryManager().getCountryData(sectionContext);
  }

  // -----------------------------
  // Update cart total safely
  // -----------------------------
  Future<void> updateCartTotalAmount() async {
    metaData.cartTotalAmount =
        metaData.cart.fold(0, (sum, item) => sum + (item.totalAmount ?? 0));
  }
}


