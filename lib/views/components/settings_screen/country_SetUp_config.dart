import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myshop_app/models/countryData.dart';
import 'package:myshop_app/services/country_currency_Manager.dart';
import '../../../constant.dart';
import '../../../res/app_colors.dart';
import '../../../utils/fonts_style.dart';
import '../../../utils/screen_size.dart';

class CountrySetupConfig extends StatefulWidget {
  const CountrySetupConfig({super.key});

  @override
  State<CountrySetupConfig> createState() => _CountrySetupConfigState();
}

class _CountrySetupConfigState extends State<CountrySetupConfig> {
  bool isTap = false;
  bool isEdited = false;
  int? activeIndex;

  List metaData = [];


  // Create a FocusNode
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    getList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isTap = false;
        isEdited = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    try {
      for (int a = 0; a < metaData.length; a++) {
        metaData[a]["rate"]["ctr"].dispose();
        metaData[a]["rate"]["nod"].dispose();
        metaData[a]["symbol"]["ctr"].dispose();
        metaData[a]["symbol"]["nod"].dispose();
        metaData[a]["code"]["ctr"].dispose();
        metaData[a]["code"]["nod"].dispose();
        metaData[a]["dp"]["ctr"].dispose();
        metaData[a]["dp"]["nod"].dispose();
      }
    } catch (_) {}
    super.dispose();
  }

  void showKeyboard() {
    // Request focus to show the keyboard
    FocusScope.of(context).requestFocus(_focusNode);
  }

  void getList() {
    // Determine list source
    List newMetaData = CountryManager().countryMetaData;
    List sourceList =  newMetaData ;

    for (int i = 0; i < sourceList.length; i++) {
      // Read values correctly depending on type
      final isMap = sourceList[i] is Map;

      final name = isMap ? sourceList[i]["name"] : sourceList[i].name;
      final rate = isMap ? sourceList[i]["rate"] : sourceList[i].rate;
      final symbol = isMap ? sourceList[i]["symbol"] : sourceList[i].symbol;
      final code = isMap ? sourceList[i]["code"] : sourceList[i].code;
      final countryCode =
      isMap ? sourceList[i]["countryCode"] : sourceList[i].countryCode;
      final dp = isMap ? sourceList[i]["dp"] : sourceList[i].dp;

      metaData.add({
        "name": {
          "ctr": TextEditingController(text: name),
          "nod": FocusNode(),
          "val": name,
        },
        "rate": {
          "ctr": TextEditingController(text: rate),
          "nod": FocusNode(),
          "val": rate,
        },
        "symbol": {
          "ctr": TextEditingController(text: symbol),
          "nod": FocusNode(),
          "val": symbol,
        },
        "code": {
          "ctr": TextEditingController(text: code),
          "nod": FocusNode(),
          "val": code,
        },
        "countryCode": {
          "ctr": TextEditingController(text: countryCode),
          "nod": FocusNode(),
          "val": countryCode,
        },
        "dp": {
          "ctr": TextEditingController(text: dp),
          "nod": FocusNode(),
          "val": dp,
        },
      });
    }
  }


  Future<void> resetValues(int exceptedIndex) async {
    for (int a = 0; a < countryList.length; a++) {
      if (a == exceptedIndex) {
        metaData[exceptedIndex]["rate"]["ctr"].text =
            countryList[exceptedIndex].rate;
        metaData[exceptedIndex]["name"]["ctr"].text =
            countryList[exceptedIndex].name;
        metaData[exceptedIndex]["symbol"]["ctr"].text =
            countryList[exceptedIndex].symbol;
        metaData[exceptedIndex]["code"]["ctr"].text =
            countryList[exceptedIndex].code;
        metaData[exceptedIndex]["countryCode"]["ctr"].text =
            countryList[exceptedIndex].countryCode;
        metaData[exceptedIndex]["dp"]["ctr"].text =
            countryList[exceptedIndex].dp;
      }
    }
  }

  Future<void> editResetValues(int exceptedIndex) async {
    for (int a = 0; a < metaData.length; a++) {
      if (a != exceptedIndex) {
        metaData[a]["name"]["ctr"].text = metaData[a]["name"]["val"];
        metaData[a]["rate"]["ctr"].text = metaData[a]["rate"]["val"];
        metaData[a]["symbol"]["ctr"].text = metaData[a]["symbol"]["val"];
        metaData[a]["code"]["ctr"].text = metaData[a]["code"]["val"];
        metaData[a]["dp"]["ctr"].text = metaData[a]["dp"]["val"];
      }
    }
  }

  void saveChanges(int index) {
    // Update the stored values
    metaData[index]["name"]["val"] = metaData[index]["name"]["ctr"].text;
    metaData[index]["rate"]["val"] = metaData[index]["rate"]["ctr"].text;
    metaData[index]["symbol"]["val"] = metaData[index]["symbol"]["ctr"].text;
    metaData[index]["code"]["val"] = metaData[index]["code"]["ctr"].text;
    metaData[index]["dp"]["val"] = metaData[index]["dp"]["ctr"].text;
    final editedCountry = CountryData(
        name:metaData[index]["name"]["val"],
        rate:  metaData[index]["rate"]["val"],
        symbol:  metaData[index]["symbol"]["val"],
        code:  metaData[index]["code"]["val"],
        dp:  metaData[index]["dp"]["val"]
    );
    CountryManager().setEditCountry(editedCountry);
    // Save to CountryManager or your persistence layer
    // Add your save logic here

    setState(() {
      isTap = false;
      isEdited = false;
      activeIndex = null;
    });
  }

  getDecimalPlaces(String value) {
    // Check if there is a decimal point
    if (value.contains('.')) {
      // Split the string by the decimal point and return the length of the decimal part
      return value.split('.')[1].length;
    }

    // If there is no decimal part, return 0
    return '0';
  }

  @override
  Widget build(BuildContext context) {

    return Animate(
      effects: const [
        FadeEffect(duration: Duration(milliseconds: 600)),
        ScaleEffect(duration: Duration(milliseconds: 600)),
      ],
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: metaData.length,
        itemBuilder: (BuildContext context, int index) {
          final item = metaData[index];   // <-- FIX: renamed for clarity
          final bool isActive = isTap && activeIndex == index;

          return Container(
            height: Displaylandscape
                ? ScreenSize().getScreenHeight(7)
                : ScreenSize().getScreenHeight(5),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize().getScreenWidth(2),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // -----------------------------
                  // FIXED name field display
                  // -----------------------------
                  Flexible(
                    flex: 1,
                    child: Text(
                      item["name"]["ctr"].text,
                      style: FontsStyle().title(),
                    ),
                  ),

                  Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildRateField(index, isActive),
                        _buildSymbolField(index, isActive),
                        _buildCodeField(index, isActive),
                        _buildDecimalField(index, isActive),
                       _buildActionButtons(index, isActive, item),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  // -----------------------------
  // Helper Widgets
  // -----------------------------

  Widget _buildRateField(int index, bool isActive) {
    return _buildTextField(
      controller: metaData[index]["rate"]["ctr"],
      focusNode: metaData[index]["rate"]["nod"],
      readOnly: !isActive,
      keyboardType: TextInputType.number,
      maxLength: 6,
      onChanged: (value) {
        CountryManager().setRate(value);
        setState(() => isEdited = true);
      },
    );
  }

  Widget _buildSymbolField(int index, bool isActive) {
    return _buildTextField(
      controller: metaData[index]["symbol"]["ctr"],
      focusNode: metaData[index]["symbol"]["nod"],
      readOnly: !isActive,
      keyboardType: TextInputType.name,
      maxLength: 3,
      onChanged: (value) {
        CountryManager().setCurrencySymbol(value);
        setState(() => isEdited = true);
      },
    );
  }

  Widget _buildCodeField(int index, bool isActive) {
    return _buildTextField(
      controller: metaData[index]["code"]["ctr"],
      focusNode: metaData[index]["code"]["nod"],
      readOnly: !isActive,
      keyboardType: TextInputType.number,
      maxLength: 3,
      onChanged: (value) {
        CountryManager().setCountryCode(value);
        setState(() => isEdited = true);
      },
    );
  }

  Widget _buildDecimalField(int index, bool isActive) {
    return _buildTextField(
      controller: metaData[index]["dp"]["ctr"],
      focusNode: metaData[index]["dp"]["nod"],
      readOnly: !isActive,
      keyboardType: TextInputType.number,
      maxLength: 1,
      inputFormatterRegex: r'[0-2]',
      onChanged: (value) {
        CountryManager().setDecimal(value);
        setState(() => isEdited = true);
      },
    );
  }

  // Generic reusable TextFormField builder
  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool readOnly,
    required TextInputType keyboardType,
    required int maxLength,
    String? inputFormatterRegex,
    required void Function(String) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Displaylandscape ? 0 : 10.0),
      child: SizedBox(
        height: Displaylandscape
            ? ScreenSize().getScreenHeight(6)
            : ScreenSize().getScreenHeight(4),
        width: Displaylandscape
            ? ScreenSize().getScreenWidth(14)
            : ScreenSize().getScreenWidth(10),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          onTapOutside: (c) => focusNode.unfocus(),
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          readOnly: readOnly,
          keyboardType: keyboardType,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: Displaylandscape
                ? ScreenSize().getScreenHeight(2.5)
                : ScreenSize().getScreenHeight(0.85),
            color: Colors.black,
            fontFamily: 'Poppins',
            letterSpacing: 3.0,
          ),
          inputFormatters: inputFormatterRegex != null
              ? [FilteringTextInputFormatter.allow(RegExp(inputFormatterRegex))]
              : null,
          maxLength: maxLength,
          onChanged: onChanged,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(113, 211, 210, 210),
            counterText: "",
            labelStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Color.fromRGBO(134, 134, 134, 1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Color.fromRGBO(134, 134, 134, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Action buttons (Edit / Cancel / Save)
  Widget _buildActionButtons(int index, bool isActive, dynamic country) {
    if (isActive) {
      return Row(
        children: [
          // Save button (only show if edited)
          if (isEdited)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: () => saveChanges(index),
                child: _buildButton(Icons.save, Colors.black),
              ),
            ),
          // Cancel button
          InkWell(
            onTap: () {
              CountryManager().emptyMemory();
              resetValues(index);
              setState(() {
                isTap = false;
                isEdited = false;
                activeIndex = null;
              });
            },
            child: _buildButton(Icons.cancel_outlined, AppColors.primary),
          ),
        ],
      );
    } else {
      return GestureDetector(
        onTap: () {
          metaData[index]["rate"]["ctr"].selection = TextSelection.fromPosition(
            TextPosition(offset: metaData[index]["rate"]["ctr"].text.length),
          );
          metaData[index]["rate"]["nod"].requestFocus();
          setState(() {
            isTap = true;
            isEdited = false;
            activeIndex = index;
          });
          // Set the active country properly
          CountryManager().setCountryName(country.name);
          editResetValues(index);
        },
        child: _buildButton(Icons.edit, Colors.black),
      );
    }
  }

  // Generic button widget
  Widget _buildButton(IconData icon, Color iconColor) {
    return Container(
      height: Displaylandscape
          ? ScreenSize().getScreenHeight(6)
          : ScreenSize().getScreenHeight(4),
      width: Displaylandscape
          ? ScreenSize().getScreenHeight(6)
          : ScreenSize().getScreenHeight(4),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(ScreenSize().getScreenHeight(0.3)),
        border: Border.all(width: 1, color: Colors.transparent),
      ),
      child: Center(child: Icon(icon, color: iconColor)),
    );
  }
}
