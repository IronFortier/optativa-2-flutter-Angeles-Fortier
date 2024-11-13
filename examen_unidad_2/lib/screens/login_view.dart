import 'package:examen_unidad_2/Widgets/general/custom_button.dart';
import 'package:examen_unidad_2/Widgets/login.dart/inputs.dart';
import 'package:examen_unidad_2/Widgets/login.dart/login_image.dart';
import 'package:examen_unidad_2/modules/login/domain/dto/acces_credential.dart';
import 'package:examen_unidad_2/modules/login/useCase/login_usecase.dart';
import 'package:examen_unidad_2/router/routers.dart';
import 'package:examen_unidad_2/Widgets/general/custom_appbar.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UClogin = LoginUseCase();

  void _login() {
    if (_usernameController.text == 'iron' &&
        _passwordController.text == '1234') {
      Navigator.pushReplacementNamed(context, Routers.categories);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Credenciales incorrectas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Login"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginImage(),
            SizedBox(height: 30),
            CustomInput(label: 'Usuario', controller: _usernameController),
            Divider(),
            CustomInput(label: 'Password', controller: _passwordController),
            SizedBox(height: 30),
            CustomButton(label: 'Ingresar', Action: () async{
              try {
                await UClogin.execute(AccesCredentials(User: _usernameController.text, Password: _passwordController.text));
                //  await CleanHistory ** por hacer
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                    getCategoriesUseCase: GetCategoriesUseCase(CategoryRepository(AuthService())),
                  ),
                ),
              );
              }
              catch (error) {
              // Muestra un error si falla la autenticación
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error al iniciar sesión: $error')),
              );
            }
            })
          ],
        ),
      ),
    );
  }
}
