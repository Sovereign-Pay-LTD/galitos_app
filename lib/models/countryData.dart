import 'dart:convert';

CountryData countryDataFromJson(String str) =>
    CountryData.fromJson(json.decode(str));

String countryDataToJson(CountryData data) => json.encode(data.toJson());

class CountryData {
  String? name;
  String? code;
  String? rate;
  String? symbol;
  String? countryCode;
  String? currency;
  String? dp;

  CountryData({
    this.name,
    this.code,
    this.rate,
    this.symbol,
    this.countryCode,
    this.currency,
    this.dp,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
        name: json["name"],
        code: json["code"],
        rate: json["rate"],
        symbol: json["symbol"],
        countryCode: json["countryCode"],
        currency: json["currency"],
        dp: json["dp"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "rate": rate,
        "symbol": symbol,
        "countryCode": countryCode,
        "currency": currency,
        "dp": dp,
      };
}
