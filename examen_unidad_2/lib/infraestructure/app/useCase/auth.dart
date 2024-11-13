import 'package:localstorage/localstorage.dart';

class Auth {
  final LocalStorage storage = LocalStorage('localstorage_app');

  String? getAuthToken() {
    String? accessToken = storage.getItem('token');
    
    return accessToken;
  }
}
