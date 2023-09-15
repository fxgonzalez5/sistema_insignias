import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:badges/models/models.dart';

class UserProvider extends ChangeNotifier {
  final String _baseUrl = 'backend-clipp-production-2fcb.up.railway.app';
  final int _userId = 1; 
  User? _user;
  final List<BadgeModel> loyaltyBadges = [];
  final List<BadgeModel> usabilityBadges = [];

  User? get user => _user;

  Future<void> loadUser() async {
    final url = Uri.https(_baseUrl, '/api/usuarios/todo/$_userId');
    final resp = await http.get(url);
    final userResponse = userFromMap(resp.body);
    _user = userResponse;
    if (loyaltyBadges.isEmpty && usabilityBadges.isEmpty) {
      loyaltyBadges.addAll(userResponse.insignias.where((badge) => badge.tipo == 'fidelización'));
      usabilityBadges.addAll(userResponse.insignias.where((badge) => badge.tipo == 'usabilidad'));
    } else {
      loyaltyBadges.clear();
      usabilityBadges.clear();
      loyaltyBadges.addAll(userResponse.insignias.where((badge) => badge.tipo == 'fidelización'));
      usabilityBadges.addAll(userResponse.insignias.where((badge) => badge.tipo == 'usabilidad'));
    }
    notifyListeners();
  }
}
