//  verificar si las credenciales son correctas

class LoginUseCase {  
  bool execute(String username, String password) {
    return username == 'iron' && password == '1234';
  }
}