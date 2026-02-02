
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myshop_app/models/countryData.dart';
import 'package:myshop_app/res/app_drawables.dart';
import 'package:myshop_app/res/app_strings.dart';

import 'models/paymentTypeData.dart';
import 'models/productCategory.dart';
const String APP_VERSION = "1.1.0";
// ignore: non_constant_identifier_names
bool Displaylandscape = true;


List<ProductCategoryData> DATA = [
  ProductCategoryData(
    category: AppStrings.drinks,
    icon: AppDrawables.drink,
    items: [
      Item(
        image: AppDrawables.drinkOne,
        price: 0.64,
        name: AppStrings.cokeZero,
        unit: AppStrings.can,
        qty: 1,
      ),
      Item(
        image: AppDrawables.drinkTwo,
        price: 2.62,
        name: AppStrings.lucozade,
        unit: AppStrings.can,
        qty: 1,
      ),
      Item(
        image: AppDrawables.drinkThree,
        price: 2.81,
        name: AppStrings.ceresRedGrapes,
        unit: AppStrings.can,
        qty: 1,
      ),
      Item(
        image: AppDrawables.drinkFour,
        price: 0.64,
        name: AppStrings.fantaZero,
        unit: AppStrings.can,
        qty: 1,
      ),
      Item(
        image: AppDrawables.drinkFive,
        price: 0.64,
        name: AppStrings.sprite,
        unit: AppStrings.can,
        qty: 1,
      ),
      Item(
        image: AppDrawables.drinkSix,
        price: 1.78,
        name: AppStrings.pepsi,
        unit: AppStrings.can,
        qty: 1,
      ),
      Item(
        image: AppDrawables.drinkSeven,
        price: 2.22,
        name: AppStrings.martinellis,
        unit: AppStrings.can,
        qty: 1,
      ),
      Item(
        image: AppDrawables.drinkEight,
        price: 2.80,
        name: AppStrings.welch,
        unit: AppStrings.can,
        qty: 1,
      ),
    ],
  ),
  ProductCategoryData(
    category: AppStrings.snacks,
    icon: AppDrawables.snacks,
    items: [
      Item(
        image: AppDrawables.snackOne,
        price: 0.64,
        name: AppStrings.oreo,
        unit: AppStrings.snacks,
        qty: 1,
      ),
      Item(
        image: AppDrawables.snackTwo,
        price: 2.23,
        name: AppStrings.shortbread,
        unit: AppStrings.snacks,
        qty: 1,
      ),
      Item(
        image: AppDrawables.snackThree,
        price: 0.96,
        name: AppStrings.famousAmos,
        unit: AppStrings.snacks,
        qty: 1,
      ),
      Item(
        image: AppDrawables.snackFour,
        price: 1.60,
        name: AppStrings.doritosCheese,
        unit: AppStrings.snacks,
        qty: 1,
      ),
      Item(
        image: AppDrawables.snackFive,
        price: 1.40,
        name: AppStrings.laysClassic,
        unit: AppStrings.snacks,
        qty: 1,
      ),
      Item(
        image: AppDrawables.snackSix,
        price: 3.66,
        name: AppStrings.kelloggCornFlakes,
        unit: AppStrings.snacks,
        qty: 1,
      ),
      Item(
        image: AppDrawables.snackSeven,
        price: 4.39,
        name: AppStrings.kelloggRiceFlakes,
        unit: AppStrings.snacks,
        qty: 1,
      ),
      Item(
        image: AppDrawables.snackEight,
        price: 3.07,
        name: AppStrings.pringles,
        unit: AppStrings.snacks,
        qty: 1,
      ),
    ],
  ),
];

List<CountryData> countryList = [
  CountryData(
    name: "Botswana",
    code: "BWP",
    rate: "13.25",
    symbol: "P",
    countryCode: "072",
    currency: "pula",
    dp: "2",
  ),
  CountryData(
    name: "Eswatini",
    code: "SZL",
    rate: "17.83",
    symbol: "E",
    countryCode: "748",
    currency: "szl",
    dp: "2",
  ),
  CountryData(
    name: "Ghana",
    code: "GHS",
    rate: "15.65",
    symbol: "¢",
    countryCode: "936",
    currency: "cedis",
    dp: "2",
  ),
  CountryData(
    name: "Kenya",
    code: "KES",
    rate: "129.00",
    symbol: "K",
    countryCode: "404",
    currency: "Kenya shilling",
    dp: "2",
  ),
  CountryData(
    name: "Malawi",
    code: "MWK",
    rate: "1734",
    symbol: "K",
    countryCode: "454",
    currency: "kwacha",
    dp: "0",
  ),
  CountryData(
    name: "Namibia",
    code: "NAD",
    rate: "17.75",
    symbol: "N\$",
    countryCode: "516",
    currency: "namibia dollor",
    dp: "2",
  ),
  CountryData(
    name: "Tanzania",
    code: "TZS",
    rate: "2718",
    symbol: "Tsh",
    countryCode: "834",
    currency: "Tanzania shilling",
    dp: "0",
  ),

  CountryData(
    name: "Uganda",
    code: "UGX",
    rate: "3716",
    symbol: "Ugx",
    countryCode: "800",
    currency: "Uganda shilling",
    dp: "0",
  ),
  CountryData(
    name: "United States",
    code: "USD",
    rate: "1.00",
    symbol: "U\$",
    countryCode: "840",
    currency: "usd",
    dp: "2",
  ),
  CountryData(
    name: "Zambia",
    code: "ZMW",
    rate: "26.28",
    symbol: "K",
    countryCode: "967",
    currency: "Zambian Kwach",
    dp: "2",
  ),
  CountryData(
    name: "Zimbabwe",
    code: "ZiG",
    rate: "13.80",
    symbol: "Z\$",
    countryCode: "924",
    currency: "zig",
    dp: "2",
  ),
];

List<PaymentData> paymentOption = [
  PaymentData(name: AppStrings.card, image: AppDrawables.card, tenderType: '01'),
  PaymentData(name: AppStrings.mobile, image: AppDrawables.mobile, tenderType: '02'),
  PaymentData(name: AppStrings.qr, image: AppDrawables.qr, tenderType: '03'),
];
