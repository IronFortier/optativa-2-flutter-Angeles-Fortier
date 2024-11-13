import 'package:examen_unidad_2/infraestructure/app/Repository/repository.dart';
import 'package:examen_unidad_2/infraestructure/connection/connection.dart';
import 'package:examen_unidad_2/modules/login/domain/dto/acces_credential.dart';
import 'package:examen_unidad_2/modules/login/domain/dto/user_login_response.dart';

class LoginRepository
    implements Repository<UserLoginResponse, AccesCredentials> {
  @override
  Future<UserLoginResponse> execute(AccesCredentials params) async {
    Connection connection = Connection();

    final data = {
      "username": params.User,
      "password": params.Password,
      "expiresInMins": 30,
    };
    String url = "https://dummyjson.com/auth/login";
    
    final response = await connection.post(url, data, headers: {
      'Content-Type': 'application/json',
    });

    return UserLoginResponse.fromJson(response);
  }
}
