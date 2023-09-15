# Reto Insignias de Fidelización de Usuario Clipp

## Autores:
* Francisco González
* Xavier Chavez
* Edgar Espinoza
* Samuel Vega
* Arelis Torres

## Descripción
En el mundo altamente competitivo de las aplicaciones móviles y plataformas en línea, la fidelización de usuarios se ha convertido en una prioridad clave para el éxito continuo. Una estrategia efectiva para lograr la fidelización de usuarios es la implementación de un sistema de otorgación de insignias, una práctica conocida como "gamificación". Esta metodología se centra en motivar y premiar a los usuarios por participar en actividades y logros dentro de la aplicación.

___Fecha de Modificación:___ 18-09-2023

___Versión:___ 1.0.0

## Instrucciones
1. Publicidad para Insignias de Usabilidad
```
/* Archivo 'helpers/show_publicity.dart' */

// Construcción de la alerta para mostrar la publicidad
showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      content: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5)
        ),
        child: Image.network(url)
      ),
      contentPadding: const EdgeInsets.all(0),
      actions: [
        MaterialButton(
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, route);
          },
          child: const Text('Completar Acción'),
        ),
        MaterialButton(
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    ),
);


/* Archivo 'screeens/home_screen.dart' */

// Uso de la Alerta para que se presente al entrar en el aplicativo
Future(() async {
    if (badgeProvider.hasStarted) {
        await publicityProvider.getAllPublicities();
        showPublicity(context, publicityProvider.allPublicities[0].imagenUrl, publicityProvider.allPublicities[0].ruta);
        badgeProvider.hasStarted = false;
    }
});
``` 
**Nota:** Como deuda técnica queda a consideración la implementación de que la publicidad se pueda volver a visualizar con una nueva imagén cuando comience una nueva semana.

2. Acciónes para Insignias de Usabilidad
```
/* Archivo 'providers/badge_provider.dart' */

// Método que permite asignar la insignia al usuario según la acción realizada
Future<void> completedActivityUsability(BuildContext context, int idBadge) async {
    final url = Uri.https(_baseUrl, '/api/registro-insignia');
    await http.post(url, headers: {'Content-Type': 'application/json',}, body: jsonEncode({"usuarioId": userId, "insigniaId": idBadge}));

    final badge = usabilityBadges.where((element) => element.id == idBadge).first;
    showAlert(context, text: badge.descripcion, url: badge.imagenUrl, isUsability: true);
}
```
- Para identificar que isignia debo entregar al usuario y en donde se debe llamar al método anteriomente mencionado.
```
/* Archivo 'screens/validate_cell_phone_screen.dart' */

// Creamos una instancia del provider y dentro de la lista de las insignias de usabilidad buscamos por el título de la misma para asignarla cuando complete la acción
final badgeProvider = Provider.of<BadgeProvider>(context, listen: false);
final BadgeModel badge = badgeProvider.usabilityBadges.where((element) => element.titulo == 'Telefono').first;
await badgeProvider.completedActivityUsability(context, badge.id);
```
**Nota:** Se deberia realizar este proceso en cada apartado donde se quiera obsequiar una insignia por usabilidad

3. Actividades para Insignias de Fidelización
```
/* Archivo 'providers/badge_provider.dart' */

// Método que permite actualizar el progreso de cada actividad
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

// Método que permite asignar la insignia conseguida al usuario y cambiar la actividad completada
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
```
- Para identificar que isignia debo entregar al usuario y en donde se debe llamar a los métodos anteriomente mencionado.
```
/* Archivo 'screens/ktaxi_screen.dart' */

// Creamos una instancia del provider y dentro de la lista de las insignias de fidelización buscamos por el nombre de la actividad para asignar la insignia cuando complete la antes mencionada
final badgeProvider = Provider.of<BadgeProvider>(context, listen: false);
final badge = badgeProvider.badges.where((element) => element.actividad!.nombre == 'Pedido de taxis').first;
await badgeProvider.updateProgresActivity(context, badge.actividad!);
```
**Nota:** Se deberia realizar este proceso en cada apartado donde se realizara la actividad para actualizar el progreso con el fin de ganar dicha insignia

4. Notificación para el Reclamo de un Cupón
```
/* Archivo 'services/notification_service.dart' */

// Creación de la notificación para informar al usuario que puede reclamar un cupón o beneficio
await AwesomeNotifications().createNotification(
  content: NotificationContent(
    id: -1,
    channelKey: 'high_importance_channel',
    title: title,
    body: body,
    payload: {'navigate': 'true'},
    actionType: actionType,
    icon: 'resource://drawable/res_clipp_icon',
    color: Colors.blue.shade900,
  ),
  actionButtons: [
    NotificationActionButton(key: '1', label: 'Canjear beneficio')
  ],
  schedule: scheduled
    ? NotificationInterval(
        interval: interval,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true,
      )
    : null,
);
```
- Para hacer uso de la notificación al momento de que se habilite el cupón a canjear se debe realizar la llamada al método cuando se ha llenado la barra de progreso. El cual podemos encontrar en el método que actualiza el progreso de las actividades en el archivo 'providers/badge_provider.dart'

5. Alerta de Nueva Insignia Obtenida y Cupón
```
/* Archivo 'providers/badge_provider.dart' */

// Creación de una variable que almacene el estado de si hay una nueva insignia que ha conseguido el usuario
bool _newBadge = false;

bool get newBadge => _newBadge;
set newBadge(bool value) {
  _newBadge = value;
  notifyListeners();
}


/* Archivo 'providers/coupon_provider.dart' */

// Creación de una variable que almacene el estado si es que el usuario ha conseguido un nuevo cupón o beneficio
bool _newCoupon = false;

bool get newCoupon => _newCoupon;
set newCoupon(bool value) {
  _newCoupon = value;
  notifyListeners();
}
```
## Librerías
- awesome_notifications: ^0.7.4+1
- cupertino_icons: ^1.0.2
- http: ^1.1.0
- provider: ^6.0.5

## Referencia de la API
[**Backend para Insignias y Publicidad Clipp**](https://github.com/XavierChavez916/backend-clipp/blob/main/README.md)

## Estructura de Directorios
- _Helpers:_ Contiene las funciones que permiten crear los Alerts Dialogs para mostrar la publicidad y la entrega de insignias.
- _Models:_ Contiene los modelos de la base de datos, mapeados en objetos para su respectiva utilización.
- _Providers:_ Contiene las variables y métodos para gestionar el estado de la aplicación, en general lo que corresponde a la lógica de negocio.
- _Screens:_ Contiene las pantallas que se presentan en la aplicación, todo lo que corresponde a la parte visual.
- _Widgets:_ Contiene componentes vizuales que se implementan en las pantallas con el objetivo de crear un código más limpio y facil de comprender.