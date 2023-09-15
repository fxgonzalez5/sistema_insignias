import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:badges/models/models.dart';
import 'package:badges/helpers/helpers.dart';
import 'package:badges/providers/providers.dart';
import 'package:badges/services/notification_service.dart';


class BadgeProvider extends ChangeNotifier {
  final String _baseUrl = 'backend-clipp-production-2fcb.up.railway.app';
  final int userId = 1;
  final List<BadgeModel> loyaltyBadges = [];
  final List<BadgeModel> usabilityBadges = [];
  final List<BadgeModel> badges = [];
  bool _newBadge = false;
  int _nextIndex = 3;
  bool _hasStarted = true;

  BadgeProvider(){
    getAllBadges();
  }

  bool get newBadge => _newBadge;
  set newBadge(bool value) {
    _newBadge = value;
    notifyListeners();
  }

  bool get hasStarted => _hasStarted;
  set hasStarted(bool value) {
    _hasStarted = value;
    notifyListeners();
  }

  getAllBadges() async {
    final url = Uri.https(_baseUrl, '/api/insignias/usuario/$userId');
    final resp = await http.get(url);
    final allBadges = badgeModelFromMap(resp.body);
    loyaltyBadges.addAll(allBadges.where((badge) => badge.tipo == 'fidelización'));
    usabilityBadges.addAll(allBadges.where((badge) => badge.tipo == 'usabilidad'));
    for (int i = 0; i < 3 ; i++){
      badges.add(loyaltyBadges[i]);
    }
    notifyListeners();
  }

  Future<void> updateProgresActivity(BuildContext context, Activity activity) async {
    int activityProgress = activity.registros[0].progreso + 1;
    final url = Uri.https(_baseUrl, '/api/registro-actividad/$userId/actividad/${activity.id}');
    await http.patch(url, headers: {'Content-Type': 'application/json',}, body: jsonEncode({"progreso": activityProgress}));

    final int index = loyaltyBadges.indexWhere((element) => element.actividad == activity);
    loyaltyBadges[index].actividad!.registros[0].progreso = activityProgress;
    
    if (activityProgress == loyaltyBadges[index].actividad!.total){
      completedActivityLoyalty(context, loyaltyBadges[index].id);
      await http.patch(url, headers: {'Content-Type': 'application/json',}, body: jsonEncode({"progreso": 0}));
      final couponProvider = Provider.of<CouponProvider>(context, listen: false);
      couponProvider.badgesEarned++;
      if (couponProvider.badgesEarned == 3) {
        NotificationService.showNotification(title: 'Conseguiste un beneficio', body: '¡Felicidades! Has llegado a la meta de insignias.\nGanaste un beneficio para ti.', scheduled: true, interval: 5);
      }
    }
  }

  completedActivityLoyalty(BuildContext context, int idBadge) async {
    final url = Uri.https(_baseUrl, '/api/registro-insignia');
    await http.post(url, headers: {'Content-Type': 'application/json',}, body: jsonEncode({"usuarioId": userId, "insigniaId": idBadge}));

    final badge = loyaltyBadges.where((element) => element.id == idBadge).first;
    showAlert(context, number: badge.actividad!.total, text: badge.actividad!.nombre, url: badge.imagenUrl);

    final int index = badges.indexWhere((element) => element.id == idBadge);
    badges.removeAt(index);
    badges.insert(index, loyaltyBadges[_nextIndex]);
    _nextIndex++;
  }

  Future<void> completedActivityUsability(BuildContext context, int idBadge) async {
    final url = Uri.https(_baseUrl, '/api/registro-insignia');
    await http.post(url, headers: {'Content-Type': 'application/json',}, body: jsonEncode({"usuarioId": userId, "insigniaId": idBadge}));

    final badge = usabilityBadges.where((element) => element.id == idBadge).first;
    showAlert(context, text: badge.descripcion, url: badge.imagenUrl, isUsability: true);
  }
}



