import 'dart:developer';

import 'package:taskapp/models/gold_model.dart';
import 'package:taskapp/services/api_service.dart';

class MetalService {
  final ApiService _service = ApiService();

  Future<GoldResponse?> getGoldData() async {
    DataResponse response = await _service.getData("XAU/USD");

    if (response.success) {
      GoldResponse gold = GoldResponse.fromMap(response.data);

      log('Got reponse just fine  ::::: $gold');

      return gold;
    }
    return null;
  }
}
