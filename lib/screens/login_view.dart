// lib/screens/login_view.dart

import 'package:examen_unidad_2/modules/login/useCase/login_usecase.dart';
import 'package:flutter/material.dart';
import 'categories_view.dart';

class LoginView extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginUseCase loginUseCase = LoginUseCase();

  void validateLogin(BuildContext context) {
    String user = userController.text;
    String password = passwordController.text;

    // Validar credenciales usando LoginUseCase
    bool isAuthenticated = loginUseCase.execute(user, password);

    if (isAuthenticated) {
      // Navegar a Categorías si el login es correcto
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CategoriesView()),
      );
    } else {
      // Mostrar un mensaje de error si el login falla
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Campos de texto para el usuario y la contraseña
                TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),

                // Botón de "Ingresar"
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => validateLogin(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Ingresar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
