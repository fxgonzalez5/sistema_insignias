import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:badges/models/models.dart';

class PublicityProvider extends ChangeNotifier {
  final String _baseUrl = 'backend-clipp-production-2fcb.up.railway.app';
  final List<Publicity> allPublicities = [];

  Future<void> getAllPublicities() async {
    final url = Uri.https(_baseUrl, '/api/publicidad');
    final resp = await http.get(url);
    final publicityResponse = publicityFromMap(resp.body);
    allPublicities.addAll(publicityResponse);
    notifyListeners();
  }
}
