import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NdviImageController with ChangeNotifier {
  String? taskid;

  Future<void> fetchNDVIImage({required List polygonVertices}) async {
    var url =
        "https://api-connect.eos.com/api/gdw/api?api_key=apk.ec441022ff2069467253ef6116de69a400841a416e5c4d2bf7c7c6ab88e7835b";
    final res = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "type": "jpeg",
        "params": {
          "view_id": "S2/13/R/EL/2023/7/19/0",
          "bm_type": "NDVI",
          "geometry": {"type": "Polygon", "coordinates": polygonVertices},
          "px_size": 4,
          "format": "png",
          "colormap": "a9bc6eceeef2a13bb88a7f641dca3aa0",
          "levels": "-1.0,1.0",
          "reference": "ref_datetime",
          "calibrate": 1,
        },
      }),
    );
    showfetchedimage();
    //  log(res.body);
    var response = jsonDecode(res.body);
    var taskid = response["task_id"];
    log(taskid);
    notifyListeners();
  }

  Future<void> showfetchedimage() async {
    var url = "https://api-connect.eos.com/api/gdw/api/$taskid";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        "x-api-key":
            "apk.ec441022ff2069467253ef6116de69a400841a416e5c4d2bf7c7c6ab88e7835b",
      },
    );
    log(res.body);
  }
}
