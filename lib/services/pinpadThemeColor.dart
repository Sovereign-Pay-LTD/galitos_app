import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'app_Manager.dart';

class PinpadThemeView extends ChangeNotifier {


  colourTheme(context) async {
    String ipaddress = await AppManager().getIPAddress();
    bool isDebugMode = await AppManager().getDebug();

    if (isDebugMode == false) {

      try {
        final url = Uri.parse('http://$ipaddress:8080/v1/colour/');
        final response = await http.post(url,
            body: jsonEncode(<String, dynamic>{"primary_color":"#17d421","secondary_color":"#ffffff"}),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            });
        //print(response.body);

        //var apiResponse = jsonDecode(response.body);

      } catch (e) {
        print("$e An error occured in the http request");
      }
    }
  }
}

