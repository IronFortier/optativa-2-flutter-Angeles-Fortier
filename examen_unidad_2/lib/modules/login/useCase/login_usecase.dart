import 'package:examen_unidad_2/infraestructure/app/useCase/usecase.dart';
import 'package:examen_unidad_2/modules/login/domain/dto/acces_credential.dart';
import 'package:examen_unidad_2/modules/login/domain/dto/user_login_response.dart';
import 'package:examen_unidad_2/modules/login/domain/repository/login_repository.dart';
import 'package:localstorage/localstorage.dart';


class LoginUseCase implements UseCase<dynamic, AccesCredentials> {

  @override
  Future<dynamic> execute(AccesCredentials params) async {
    final AccesCredentials CredentialS = AccesCredentials(
      User: params.User,
      Password: params.Password,
    );
    // Ejecuta el login y recibe la respuesta
    final UserLoginResponse response = await LoginRepository().execute(CredentialS);

    // Guarda el token 
    final LocalStorage storage = LocalStorage('localstorage_app');
    await storage.clear(); 
    await storage.setItem('token', response.token);

    return response;
  }

  

}
