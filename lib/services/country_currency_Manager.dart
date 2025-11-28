
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import '../models/countryData.dart';
import '../res/app_strings.dart';
import '../res/app_theme.dart';

class CountryManager {
  CountryManager._internal();

  static final CountryManager _instance = CountryManager._internal();
  factory CountryManager() => _instance;
  static CountryManager get instance => _instance;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Default country
  CountryData activeCountry = countryList[8];

  List<CountryData> countryMetaData = countryList;
  List<CountryData> editedCountriesList =[];
  bool activeStartBtn = false;

  // -------------------------------------------------------------
  // CHANGE CURRENCY (updated)
  // -------------------------------------------------------------
  Future<void> changeCurrency(context, String value) async {
    List<CountryData> sourceList = countryMetaData ;

    // Find matching country
    activeCountry = sourceList.firstWhere(
          (c) => c.code == value,
      orElse: () => countryList[8], // safe fallback
    );

    print('Updated active currency: ${activeCountry.code}');
    await saveActiveCountry();
  }

  // -------------------------------------------------------------
  Future<void> setRate(value) async {
    activeCountry.rate = value;
    activeBtn(true);
    await saveActiveCountry();
  }

  Future<void> setCountryCode(value) async {
    activeCountry.countryCode = value;
    activeBtn(true);
    await saveActiveCountry();
  }
  Future<void> setCountryName(value) async {
    activeCountry.name = value;
    activeBtn(true);
    await saveActiveCountry();
  }
  Future<void> setCurrencySymbol(value) async {
    activeCountry.symbol = value;
    activeBtn(true);
    await saveActiveCountry();
  }
  Future<void> setDecimal(value) async {
    activeCountry.dp = value;
    activeBtn(true);
    await saveActiveCountry();
  }

  activeBtn(bool status) {
    activeStartBtn = status;
  }

  Future<void> countryChecker(String value) async {
    activeCountry.code = value;
    activeBtn(true);
    await saveActiveCountry();
  }

  Future<void> currencySymbol(String value) async {
    activeCountry.symbol = value;
    activeBtn(true);
    await saveActiveCountry();
  }

  Future<void> dropdownSelectedCountry(String value) async {
    final prefs = await _prefs;
    await prefs.setString('selectDropdown', value);

    activeCountry.code = value;
    await saveActiveCountry();
  }

  getDefault(value) {
    if (value == null) {
      activeCountry = countryList[8];
    }
  }

  getCountryName(String name) {
    activeCountry.name = name;
    saveActiveCountry();
  }
  setEditCountry(CountryData data) {

    editedCountriesList.add(data);

  }

  saveCountrySettings() {
if(editedCountriesList.isNotEmpty){
  for (var editedCountry in editedCountriesList) {
    final country = editedCountry;

    // Assuming countryMetaData is a List<CountryData>
    final index = countryMetaData.indexWhere((c) => c.name == country.name);

    if (index != -1) {
      // Update existing
      countryMetaData[index].symbol = editedCountry.symbol;
      countryMetaData[index].rate = editedCountry.rate;
      countryMetaData[index].code = editedCountry.code;
      countryMetaData[index].dp = editedCountry.dp;

    } else {
      // Add new
      countryMetaData.add(editedCountry);
    }
    editedCountriesList =[];
  }

  AppUtil.toastMessage(message: AppStrings.successFulSettings);
}
else{
  AppUtil.toastMessage(message: AppStrings.noChangesMade);
}


  }
  // -------------------------------------------------------------
  // LOAD ACTIVE COUNTRY DATA
  // -------------------------------------------------------------
  getCountryData(context) async {
    final prefs = await _prefs;

    String savedCode = prefs.getString('selectDropdown') ?? "USD";

    await changeCurrency(context, savedCode);

    return activeCountry;
  }

  // -------------------------------------------------------------
  saveCountryData(context, mapData) async {
    activeCountry.name = mapData["name"];
    activeCountry.dp = mapData["dp"];
    activeCountry.rate = mapData["rate"];
    activeCountry.countryCode = mapData["countryCode"];
    activeCountry.symbol = mapData["symbol"];
    activeCountry.currency = mapData["currency"];
    activeCountry.code = mapData["code"];

    await saveActiveCountry();
  }

  // -------------------------------------------------------------
  // SAVE / LOAD SHARED PREFS
  // -------------------------------------------------------------
  Future<void> saveActiveCountry() async {
    final prefs = await _prefs;

    await prefs.setString("country_name", activeCountry.name ?? "");
    await prefs.setString("country_code", activeCountry.code ?? "");
    await prefs.setString("country_iso_code", activeCountry.countryCode ?? "");
    await prefs.setString("country_symbol", activeCountry.symbol ?? "");
    await prefs.setString("currency", activeCountry.currency ?? "");
    await prefs.setDouble("country_rate",
        double.tryParse(activeCountry.rate.toString()) ?? 1.0);
    await prefs.setInt("country_dp",
        int.tryParse(activeCountry.dp.toString()) ?? 2);
  }

  Future<void> loadActiveCountry() async {
    final prefs = await _prefs;

    String? code = prefs.getString("country_code");
    if (code == null || code.isEmpty) return;

    activeCountry = CountryData(
      name: prefs.getString("country_name"),
      code: prefs.getString("country_code"),
      symbol: prefs.getString("country_symbol"),
      countryCode: prefs.getString("country_iso_code"),
      currency: prefs.getString("currency"),
      rate: prefs.getDouble("country_rate")?.toString(),
      dp: prefs.getInt("country_dp")?.toString(),
    );

    //print("Loaded country: ${activeCountry.toJson()}");
  }

  // -------------------------------------------------------------
  // UPDATE LIST
  // -------------------------------------------------------------
  void updateList(List newList) {
    countryMetaData = newList.map<CountryData>((item) {
      return CountryData(
        name: item["name"],
        dp: item["dp"],
        rate: item["rate"],
        countryCode: item["countryCode"],
        symbol: item["symbol"],
        currency: item['currency'],
        code: item["code"],
      );
    }).toList();
  }

  void resetToDefaults(){
    countryMetaData = countryList;
  }

  void emptyMemory() {
    activeBtn(false);
    activeCountry = countryList[8];
    saveActiveCountry();
  }
}



