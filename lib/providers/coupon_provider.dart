import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:badges/models/models.dart';

class CouponProvider extends ChangeNotifier {
  final String _baseUrl = 'backend-clipp-production-2fcb.up.railway.app';
  final int userId = 1;
  final List<Coupon> allCoupons = [];
  bool _newCoupon = false;
  int _badgesEarned = 0;

  CouponProvider() {
    getAllCoupons();
  }

  bool get newCoupon => _newCoupon;
  set newCoupon(bool value) {
    _newCoupon = value;
    notifyListeners();
  }

  int get badgesEarned => _badgesEarned;
  set badgesEarned(int value) {
    _badgesEarned = value;
    notifyListeners();
  }

  getAllCoupons() async {
    final url = Uri.https(_baseUrl, '/api/beneficios');
    final resp = await http.get(url);
    final couponResponse = couponFromMap(resp.body);
    allCoupons.addAll(couponResponse);
    notifyListeners();
  }

  Future<void> couponAssignment(BuildContext context, int idCoupon) async {
    final url = Uri.https(_baseUrl, '/api/registro-beneficio');
    await http.post(url, headers: {'Content-Type': 'application/json',}, body: jsonEncode({"usuarioId": userId, "beneficioId": idCoupon}));
  }
}
