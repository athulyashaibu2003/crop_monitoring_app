import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NdviImageController with ChangeNotifier {
  Future<void> fetchNDVIImage() async {
    var url =
        "https://api-connect.eos.com/api/gdw/api?api_key=apk.ec441022ff2069467253ef6116de69a400841a416e5c4d2bf7c7c6ab88e7835b";
    final res = await http.post(Uri.parse(url));
    notifyListeners();
    log(res.body);
  }
}
