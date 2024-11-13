import 'dart:convert';
import 'package:http/http.dart' as http;

class Connection {
  @override
  Future<T> get<T>(String url, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as T;
      } else {
        throw Exception('Fallo la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error en la conexion: $error');
    }
  }

  @override
  Future<T> post<T, D>(String url, D data, {Map<String, String>? headers}) async {   

    try {
      final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as T;
      } else {
        throw Exception('Fallo la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error en la conexion: $error');
    }
  }

  @override
  delete<T>(String url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  put<T, D>(String url, D data, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }
}
